import 'dart:math';

import 'package:flutter/material.dart';
import 'package:final_mwinda_app/utils/utils.dart';
import 'package:final_mwinda_app/pages/blog/post.dart';
import 'package:http/http.dart' as http;
//import 'package:mwinda_app/app_screens/posts/post_detail.dart';
import 'dart:async';
import 'dart:convert';

var COLORS = [
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.lightGreen,
  Colors.yellowAccent,
  Colors.deepPurple
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/200?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/100?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/150?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/125?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/175?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/225?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/250?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/350?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/275?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/300?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": COLORS[new Random().nextInt(5)],
      "image": "https://picsum.photos/325?random"
    }
  ];



  Future<List<Post>> showPosts() async {
    debugPrint('000000000000000000');
    var data = await http.get('https://mwinda-rdc.org/mobileapi/blog/posts');
      debugPrint("11111111111");
    var dataDecoded = json.decode(data.body);
      debugPrint("2222222");

    List<Post> posts = List();
    dataDecoded['result'].forEach((post){
      debugPrint("3333333" + post.tospring());

      String title = post["title"];
      if(title.length>25){
        title = post["title"]; //.substring(1,25) + "...";
      }
      String body = post["article"].replaceAll(RegExp(r'\n'), " ");
      posts.add(new Post(title, body, post["image"]));
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text(
          widget.title!=null?widget.title:'',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),


            child: FutureBuilder(
              future: showPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                    



             new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              primary: true,
              itemCount: snapshot.data.length, //data.length,
              itemBuilder: (BuildContext content, int index) {
                return AwesomeListItem(
                    title: snapshot.data[index].title,
                    content: 'Lorem Ipsum',//snapshot.data[index]["content"],
                    color: Colors.lightGreen[100],//[index]["color"],
                    image: snapshot.data[index].image
                  );
              },
            );



                } else {
                  return Align(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  );
                }
              }
            )



          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              child: new ClipPath(
                clipper: new MyClipper(),
                child: new Stack(
                  children: [
                    new Image.asset('assets/images/rubriq_actualites.jpg', fit: BoxFit.fill),                        
                    new Opacity(
                      opacity: 0.2,
                      child: new Container(color: COLORS[0]),
                    ),
                    // Title on main baner
                    new Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: new ListTile(
                        /*leading: new CircleAvatar(
                          child: new Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4"),
                              ),
                            ),
                          ),
                        ),*/
                        title: new Text(
                          "Tous les articles",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 28.0,
                              letterSpacing: 2.0,        
                              shadows: [
                                Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                ),
                              ],
                          ),
                        ),
                        /*subtitle: new Text(
                          "Lead Designer",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0),
                        ),*/
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.title, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: const EdgeInsets.only(left:0.0, right:0.0, top:5.0, bottom:5.0), 
      color: Colors.lightBlue[100], 
      child: new Row(
        children: <Widget>[
          new Container(
            width: 5.0, height: 190.0, color: Colors.lightBlue,
          ),
          new Expanded(
            child: new Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: new Text(
                      widget.content,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Contient l'image d'un item de la liste'
          new Container(
            height: 150.0,
            width: 150.0,
            color: Colors.lightBlue[100],
            child: Stack(
              children: <Widget>[
                new Transform.translate(
                  offset: new Offset(50.0, -10.0),
                  child: new Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(14.0),
                      color: widget.color,
                    ),
                  ),
                ),
                new Transform.translate(
                  offset: Offset(10.0, 0.0),
                  child: new Card(
                    elevation: 10.0,
                    child: new Container(
                      height: 150.0,
                      width: 150.0,
                      //color: Colors.lightBlue[100],
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: Colors.lightBlue[100],
                          image: DecorationImage(
                            image: AssetImage(AvailableImages.rubriqActualites['assetPath']),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
