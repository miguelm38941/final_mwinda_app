import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'global.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isRecording = false;
  bool uploadingAudio = false;
  TextEditingController message = new TextEditingController();

  chkper() async {
    bool hasPermissions = await AudioRecorder.hasPermissions;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.ChatTitle),
        actions: <Widget>[
          Global.isGroup
              ? GestureDetector(
                  onTap: () {
                    Global.EditGroup = true;
                    Navigator.of(context).pushNamed('createGroup');
                  },
                  child: Icon(Icons.settings),
                )
              : SizedBox()
        ],
      ),
      body: Container (
        color: Colors.lightBlue[50],
        child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('Chats')
                  .document('chat')
                  .collection(Global.currentChat)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      reverse: true,
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return document['uid'] == Global.Uid
                            ? RightTile(
                                id: document['uid'],
                                text: document['msg'],
                                type: document['type'],
                                document: document)
                            : LeftTile(
                                id: document['uid'],
                                text: document['msg'],
                                type: document['type'],
                                document: document);
                      }).toList(),
                    );
                }
              },
            ),
          ),
          Container(
            color: Colors.lightBlue[200],
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                onLongPressStart: (start) async {
                  isRecording = true;

                  setState(() {});
                  await AudioRecorder.start(
                      audioOutputFormat: AudioOutputFormat.AAC);
                },
                onLongPressEnd: (start) async {
                  isRecording = false;
                  uploadingAudio = true;
                  setState(() {});
                  Recording recording = await AudioRecorder.stop();
                  print(
                      "Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");

                  final StorageReference storageReferencem = FirebaseStorage()
                      .ref()
                      .child(Global.Uid +
                          "/" +
                          "${DateTime.now().millisecondsSinceEpoch}.m4a");
                  final StorageUploadTask uploadTaskm =
                      storageReferencem.putFile(await File(recording.path));
                  await uploadTaskm.onComplete;
                  await storageReferencem.getDownloadURL().then((url) {
                    print("Download URL : " + url);

                    Firestore.instance
                        .collection('Chats')
                        .document('chat')
                        .collection(Global.currentChat)
                        .document()
                        .setData({
                      'msgby': Global.Username,
                      'msg': url,
                      'type': "audio",
                      'timestamp': FieldValue.serverTimestamp(),
                      'uid': Global.Uid,
                      'duration': recording.duration.toString()
                    });
                  });

                  uploadingAudio = false;
                  setState(() {});
                },
                child: Card(
                    color: isRecording ? Colors.green[700] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: uploadingAudio
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation(Colors.red),
                            )
                          : Icon(Icons.mic),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  GetImage();
                },
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.image),
                )),
              ),
              Expanded(
                  child: Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                      controller: message,
                      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 10.0), fillColor: Colors.lightBlueAccent),
                    )),
                    GestureDetector(
                      onTap: () {
                        if (message.text != null &&
                            message.text.toString() != "") {
                          //  Fluttertoast.showToast(msg: message.text);
                          Global.isGroup
                              ? EnterGroupData(
                                  Data: message.text.toString(),
                                  type: "text",
                                )
                              : EnterData(
                                  Data: message.text.toString(),
                                  type: "text",
                                );
                          message.text = "";
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.send, color: Colors.blueAccent,),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
          ),
        ],
      ),
    ),
    );
  }
}

/*class LeftTile extends StatelessWidget {

  String id;
  String text;
  String type;

  LeftTile({this.id, this.text,this.type});

  @override
  Widget build(BuildContext context) {
    return  Container(

      child: Card(
        child: Padding(padding: EdgeInsets.all(10),child:
        type=="text"?
        Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(text),
            Text("@"+id,style: TextStyle(color: Colors.grey[500],fontSize: 12),),
          ],
        ):
        type =="image"?
        Image.network(text):
        GestureDetector(
          onTap: (){
            AudioPlayer audioplayer=new AudioPlayer();
            audioplayer.play(text);
          },
          child:    Icon(Icons.play_arrow),
        )
          ,),

      ),
    );
  }
}*/

/*class LeftTile extends StatelessWidget {
  AudioPlayer audioplayer=new AudioPlayer();
  String id;
  String text;
  String type;
  DocumentSnapshot document;
  var _positionSubscription;
  var duration;

  double currentvalue=0;

  LeftTile({this.id, this.text,this.type,this.document});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Card(
              elevation: 5,
              color: Colors.green[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
              ),
              child: Padding(padding: EdgeInsets.all(10),child:

              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width*.7
                    ),
                    child:  type=="text"?
                    Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(text),


                      ],
                    ) :

                    type =="image"?
                    Image.network(text):
                    GestureDetector(
                      onTap: () async {
                        print("clicked");



                        audioplayer.play(text);

                      },
                      child:    Icon(Icons.play_arrow,color: Colors.blue[700],),
                    ),
                  ),
                  Text("-"+document['msgby'])
                ],
              )



              ),
            ),
          ],

        ),

      ],
    );
  }
}*/

class LeftTile extends StatelessWidget {
  AudioPlayer audioplayer = new AudioPlayer();
  String id;
  String text;
  String type;
  bool isPlaying = false;
  String duration = "-";
  DocumentSnapshot document;
  var _positionSubscription;
  double currentvalue = 0;
  double value = 0;
  LeftTile({this.id, this.text, this.type, this.document});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          child: Column(
            children: <Widget>[
              Container(
                child: new Padding(
                    padding: EdgeInsets.all(10),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .7),
                      child: type == "text"
                          ? Container(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(text,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                              ],
                            ))
                          : type == "image"
                              ? Image.network(text)
                              : GestureDetector(
                                  onTap: () async {
                                    print("clicked");
                                    audioplayer.play(text);
                                    isPlaying = !isPlaying;
                                    (context as Element).markNeedsBuild();

                                    audioplayer.onAudioPositionChanged
                                        .listen((Duration p) {
                                      value = double.parse(
                                          p.inMilliseconds.toString());
                                      (context as Element).markNeedsBuild();
                                    });

                                    audioplayer.onPlayerCompletion
                                        .listen((event) {
                                      value = 0;
                                      isPlaying = !isPlaying;
                                      (context as Element).markNeedsBuild();
                                    });
                                  },
                                  child: Container(
                                    color: Colors.grey[100],
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.blue[700],
                                      ),
                                      Slider(
                                          value: value,
                                          onChanged: null,
                                          min: 0,
                                          max: double.parse(parseDuration(
                                                  document['duration'])
                                              .inMilliseconds
                                              .toString())),
                                      Text(parseDuration(document['duration'])
                                              .inMinutes
                                              .toString() +
                                          ":" +
                                          parseDuration(document['duration'])
                                              .inSeconds
                                              .toString())
                                    ],
                                  ),                                    
                                  )
                                ),
                    )),
              ),
              Container(
                  color: Colors.green[50],
                  child: Padding(
                    child: Text(
                      "-" + document['msgby'],
                      style: TextStyle(fontSize: 10.0),
                    ),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}

class RightTile extends StatelessWidget {
  AudioPlayer audioplayer = new AudioPlayer();
  String id;
  String text;
  String type;
  bool isPlaying = false;
  String duration = "-";
  DocumentSnapshot document;
  var _positionSubscription;
  double currentvalue = 0;
  double value = 0;
  RightTile({this.id, this.text, this.type, this.document});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Card(
          elevation: 5,
          color: Colors.green[100],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          )),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .7),
                child: type == "text"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            )
                          ),
                         ],
                      )
                    : type == "image"
                        ? Image.network(text)
                        : GestureDetector(
                            onTap: () async {
                              print("clicked");
                              audioplayer.play(text);
                              isPlaying = !isPlaying;
                              (context as Element).markNeedsBuild();

                              audioplayer.onAudioPositionChanged
                                  .listen((Duration p) {
                                value =
                                    double.parse(p.inMilliseconds.toString());
                                (context as Element).markNeedsBuild();
                              });

                              audioplayer.onPlayerCompletion.listen((event) {
                                value = 0;
                                isPlaying = !isPlaying;
                                (context as Element).markNeedsBuild();
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.blue[700],
                                ),
                                Slider(
                                    value: value,
                                    onChanged: null,
                                    min: 0,
                                    max: double.parse(
                                        parseDuration(document['duration'])
                                            .inMilliseconds
                                            .toString())),
                                Text(parseDuration(document['duration'])
                                        .inMinutes
                                        .toString() +
                                    ":" +
                                    parseDuration(document['duration'])
                                        .inSeconds
                                        .toString())
                              ],
                            ),
                          ),
              )),
        ),
      ],
    );
  }
}

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}
