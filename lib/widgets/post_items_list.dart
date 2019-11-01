import 'dart:math';

import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/utils/utils.dart';
import 'package:final_mwinda_app/pages/blog/post.dart';
import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';

class AwesomeListItem extends StatefulWidget {
  int id;
  String title;
  String category;
  String content;
  Color color;
  String image;

  AwesomeListItem({this.id, this.title, this.category, this.content, this.color, this.image});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    //debugPrint('IIIID ' + widget.id.toString());
    return Container( 
      margin: const EdgeInsets.only(left:0.0, right:0.0, top:2.0, bottom:2.0), 
      color: Colors.lightBlue[100], 
      child: new Row(
        children: <Widget>[
          new Container(
            width: 5.0, height: 190.0, color: Colors.lightBlue,
          ),
          new Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context, 
                singlePostPageRoute, 
                arguments: widget.id.toString()
              ),
              child: new Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      StringUtils.capitalize(widget.title),
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: new Text(
                        widget.category,
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ) 
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
                //if (widget.image.contains('images')) {
                  new Transform.translate(
                    offset: Offset(10.0, 0.0),
                    //child: new Card(
                      //elevation: 10.0,
                      child: ClipRRect(
                          borderRadius: new BorderRadius.circular(20.0),
                          child: Image.network(
                              widget.image,
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.fitHeight,
                          ),
                      ),
                    //),
                  ),
                /*} else {
                  new Transform.translate(
                    offset: Offset(10.0, 0.0),
                    //child: new Card(
                      //elevation: 10.0,
                      child: ClipRRect(
                          borderRadius: new BorderRadius.circular(20.0),
                          child: Container(
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
                    //),
                  ),
                }*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
