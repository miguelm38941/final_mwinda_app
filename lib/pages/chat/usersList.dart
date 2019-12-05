import 'global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  TextEditingController _number = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Pages Starts here");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(/*"Chat"*/"Conversations"),actions: <Widget>[ GestureDetector(
        onTap: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.clear();
        Global.Username=null;
        Global.Uid=null;
        Global.currentChat=null;
        Global.ChatTitle=null;
        Global.OtherUserId=null;
        Global.isGroup=false;
        Global.EditGroup=false;
        Navigator.of(context).pushNamed('login');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.exit_to_app),
        ),
      )],),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').document(Global.Uid).collection('chat').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return snapshot.data.documents.isNotEmpty? ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  debugPrint(document.toString());
                  return Column(
                    children: <Widget>[
                      new ListTile(onTap: (){
                        Global.currentChat=document.documentID;
                        if(document['groupchat']==false) {
                          if (int.parse(Global.currentChat) >
                              int.parse(Global.Uid)) {
                            Global.currentChat =
                                Global.currentChat + "+" + Global.Uid;
                          }else
                            {
                              Global.currentChat =
                                  Global.Uid + "+" + Global.currentChat;
                            }
                          Global.isGroup=false;
                        }else
                          {
                            Global.isGroup=true;
                          }

                        Global.EditGroup=false;
                        print(document);
                        Global.ChatTitle=document['name'].toString();
                        Global.OtherUserId=document.documentID;
                        Navigator.of(context).pushNamed('chat');
                   //     Fluttertoast.showToast(msg:  Global.currentChat,toastLength: Toast.LENGTH_LONG);
                      },
                        title: new Text(document['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle:
                        document['msgby']==null?
                       Text("Nouvelle Conversation"): Row(
                          children: <Widget>[
                            new Text(document['msgby']??""+" : ",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(width: 10,),
                            document['type']=="text"?
                            new Text(document['msg']??""):
                            document['type']=="image"?Icon(Icons.image):Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                        thickness: 2,
                      )
                    ],
                  );
                }).toList(),
              ):Center(child:Text("No Chat"));
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /*FloatingActionButton(backgroundColor: Global.MainColor,heroTag: "tg0",onPressed: (){
            Global.EditGroup=false;
            Navigator.of(context).pushNamed('selectUser');
          },child: Icon(Icons.chat_bubble_outline),),
          SizedBox(width: 15,),*/
          FloatingActionButton(backgroundColor: Global.MainColor,heroTag: "tg1",onPressed: (){
            showDialog(context: context,builder: (context){
              return SimpleDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.all(0),
                backgroundColor: Colors.blue[300],
                children: <Widget>[

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top:Radius.circular(10) ),
                      color: Colors.blue[900],
                    ),
               child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Nouvelle conversation",style: TextStyle(fontSize:MediaQuery.of(context).size.width*.05,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,10,20,0),
                    child: Column(
                      children: <Widget>[
                        TextField(controller: _number,decoration: InputDecoration(filled:true,fillColor: Colors.white,hintText: "Number",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),),
                        SizedBox(height: 10,),
                        RaisedButton(color: Colors.blue[900],onPressed: () async {


                        print( await AvailableUser(context,number: _number.text.toString()));
               //   Navigator.of(context).pop();
                //  Fluttertoast.showToast(msg: "checking");
                        },child: Text("Continuer",style: TextStyle(color: Colors.white),) ,),
                      ],
                    ),
                  ),
                ],
              );
            });
          },child: Icon(Icons.chat),),
          SizedBox(width: 15,),
          FloatingActionButton(backgroundColor: Global.MainColor,onPressed: (){
            Global.EditGroup=false;
            Navigator.of(context).pushNamed('selectUsers');
          },child: Icon(Icons.question_answer),heroTag: "tg2",),
        ],
      ),
    );
  }
}
