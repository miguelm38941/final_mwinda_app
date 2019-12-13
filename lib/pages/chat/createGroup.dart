import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_mwinda_app/utils/phone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'global.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _number = new TextEditingController();
  List<String> users = new List();
  List<String> usersName = new List();
  String admin ="";
  bool isloading=false;

  DocumentSnapshot documentSnapshot;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Global.EditGroup==true) {
      GetGroupDetails();
    }else
      {
        users=[...Global.users];
        usersName=[...Global.username];
      }
 //  Fluttertoast.showToast(msg:  Global.EditGroup==true?"Bhai edit krna hai":"Create Karna");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(/*"Create Group"*/"Créer groupe")),
      floatingActionButton:Global.EditGroup==true?admin==Global.Uid? FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        showDialog(context: context,builder: (context){
          return SimpleDialog(
            contentPadding: EdgeInsets.all(20),
            children: <Widget>[

              TextField(controller: _number,decoration: InputDecoration(hintText: /*"Number"*/"Téléphone",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),),
              SizedBox(height: 10,),

              RaisedButton(onPressed: () async {


               if( users.contains(_number.text.toString()))
                 {
                   Fluttertoast.showToast(msg: /*"User Already Added"*/"Déjà inscrit, se connecter ici");
                 }else {
                 DocumentSnapshot documentSnapshot = await GetUserDetails(
                     context, number: _number.text.toString(), answer: true);


                 if (documentSnapshot!=null) {
                   users.add(_number.text.toString());
                   usersName.add(documentSnapshot['name']);

                   if(Global.EditGroup==true && admin==Global.Uid) {
                     UpdateGroup(context, users: users,usersName: usersName,
                         number: _number.text.toString(),
                         name: _name.text.toString());
                   }
                   Navigator.of(context).pop();
                   setState(() {

                   });
                 }

            //     Fluttertoast.showToast(msg: "checking");
               }

              },child: Text(/*"Continue"*/"Continuer") ,),
            ],
          );
        });

      },):SizedBox():FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        showDialog(context: context,builder: (context){

       return   SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: EdgeInsets.all(0),
            backgroundColor: Colors.lightBlue,
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
                      child: Text(/*"New Conversation with"*/"Ajouter un utilisateur",style: TextStyle(fontSize:MediaQuery.of(context).size.width*.05,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),),

              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20,0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _number,
                      decoration: InputDecoration(filled:true,fillColor: Colors.white,hintText: /*"Number"*/"Téléphone",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),                          
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                                              PhoneFormatter(),
                                            ],
),
                    SizedBox(height: 10,),
                    RaisedButton(color: Colors.blue[900],onPressed: () async {
                      if( users.contains(_number.text.toString()))
                      {
                        Fluttertoast.showToast(msg: /*"User Already Added"*/"Déjà inscrit, se connecter ici");
                      }else {
                        DocumentSnapshot documentSnapshot = await GetUserDetails(
                            context, number: _number.text.toString(), answer: true);

                        print(documentSnapshot);
                        if (documentSnapshot!=null) {
                          users.add(_number.text.toString());
                          usersName.add(documentSnapshot['name']);

                          if(Global.EditGroup==true && admin==Global.Uid) {
                            UpdateGroup(context, users: users,usersName: usersName,
                                number: _number.text.toString(),
                                name: _name.text.toString());
                          }
                          Navigator.of(context).pop();
                          setState(() {

                          });
                        }

                    //    Fluttertoast.showToast(msg: "checking");
                      }
                    },child: Text(/*"Continue"*/"Continuer",style: TextStyle(color: Colors.white),) ,),
                  ],
                ),
              ),
            ],
          );


        });

      },),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(enabled: Global.EditGroup==true?false:true,controller: _name,decoration: InputDecoration(hintText: /*"Name"*/"Nom du groupe",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),),
          ),
          Container(color:Global.MainColor,width: MediaQuery.of(context).size.width,height: 40,child: Center(child: Text("Membres",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),)
          ,Expanded(child: ListView.builder(
          itemCount: users.length,itemBuilder: (c,i){
            return Column(
              children: <Widget>[



                ListTile(title: Text(usersName[i]),subtitle:Text(users[i]) ,trailing:

            Global.EditGroup==false || Global.Uid==admin?
                GestureDetector(onTap: (){
                  users.removeAt(i);
                  usersName.removeAt(i);

                  if(Global.EditGroup==false &&Global.Uid==admin)
                    {
                      UpdateGroupAfterDelete(context,name: _name.text,number: users[i],users: users,usersName: usersName);
                    }


                  setState(() {

                  });
                },child: Icon(Icons.remove_circle,color: Global.MainColor,)):SizedBox(),),
                Divider(thickness: 2,)
              ],
            );
          })),
          GestureDetector(onTap: (){

            isloading=true;
            setState(() {

            });

            if(_name.text.toString()==null||_name.text.toString()=="")
              {
                Fluttertoast.showToast(msg: "Veuillez donnez un nom au groupe");
              }else if(users.isEmpty)
                {
                  Fluttertoast.showToast(msg: "Veuillez ajouter des membres a votre groupe");
                }else{
              AddGroup(context,name:_name.text.toString(),users: users ,usersName: usersName);
            }

            isloading=false;
            setState(() {

            });

          },child: Global.EditGroup==true?SizedBox():
          Container(color:Global.MainColor,width: MediaQuery.of(context).size.width,height: 50,child: Center(child: isloading?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.red),backgroundColor: Colors.white,):Text("Enregistrer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),))
        ],
      ),
    );
  }



  GetGroupDetails()
  async {

    print("Getting Group Details");



    await Firestore.instance
        .collection('users')
        .document(Global.Uid)
        .collection('chat')
        .document(Global.currentChat)
        .get()
        .then((ds) {

      documentSnapshot=ds;
      _name.text=ds['name'];
      admin=ds['admin'];

    List<String> oldUsers= ds['users'].cast<String>();
      List<String> oldUsersName= ds['usersName'].cast<String>();

    users=[...oldUsers];
      usersName=[...oldUsersName];

setState((){});


    }).catchError((error){
      print(error);
    });

  }





  UpdateGroup(context,{String name,List<String> users,List<String> usersName,String number}) async {


   await Firestore.instance
        .collection('users')
        .document(number)
        .collection('chat')
        .document(Global.currentChat)
        .setData({
      'type':'group',
      'name':name,
      'users':users,
     'usersName':usersName,
      'admin':Global.Uid
    });


    for(int i =0;i<users.length;i++)
    {
      await Firestore.instance
          .collection('users')
          .document(users[i])
          .collection('chat')
          .document(Global.currentChat)
          .updateData({
        'users':users,
        'usersName':usersName,
        'admin':Global.Uid
      });
    }
    Navigator.of(context).pushNamed('chat');
  }


  UpdateGroupAfterDelete(context,{String name,List<String> users,List<String> usersName,String number}) async {




    if(number==admin && users.isNotEmpty)
{
  admin=users[0];
}
    await Firestore.instance
        .collection('users')
        .document(number)
        .collection('chat')
        .document(Global.currentChat)
        .delete();


    for(int i =0;i<users.length;i++)
    {
      await Firestore.instance
          .collection('users')
          .document(users[i])
          .collection('chat')
          .document(Global.currentChat)
          .updateData({
        'users':users,
        'usersName':usersName,
        'admin':admin
      });
    }
    Navigator.of(context).pushNamed('chat');
  }





}
