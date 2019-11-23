import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'global.dart';

class SelectUser extends StatefulWidget {
  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {

  List<String> users = new List();
  List<String> names = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(/*"Select Users"*/"Sélectionner"),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('users').document(Global.Uid).collection('chat').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return new Text('Loading...');
                  default:
                    return snapshot.data.documents.isNotEmpty? ListView(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return document['groupchat']?SizedBox(): Column(
                          children: <Widget>[
                            Container(
                       color: users.contains(document['phone'])?Colors.red[200]:Colors.transparent ,
                              child: new ListTile(

                          onTap: (){

                            if(users.contains(document['phone']))
                              {
                                int index = users.indexOf(document['phone']);
                                users.removeAt(index);
                                names.removeAt(index);

                              }else
                                {
                                  users.add(document['phone']);
                                  names.add(document['name']);
                                }

                            setState(() {

                            });
                              },
                                title: new Text(document['name']),
                                subtitle:
                                Row(
                                  children: <Widget>[
                                    new Text(document['phone'],style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
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
          ),
          GestureDetector(onTap:( ){
            Global.users=users;
            Global.username=names;
            Navigator.of(context).pushReplacementNamed('createGroup');
          },child: Container(color:Global.MainColor,width: MediaQuery.of(context).size.width,height: 40,child: Center(child: Text(/*"Next"*/"Ajouter",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),))
        ],
      ),
    );
  }
}
