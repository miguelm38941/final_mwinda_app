import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  SharedPreferences _sharedPreferences;
  bool isLoading=false;

  TextEditingController _name = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Global.MainColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(controller: _name,decoration: InputDecoration(filled: true,fillColor: Colors.white,hintText: /*"Name"*/"Nom d'utilisateur",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),),
                    SizedBox(height: 10,),
                    TextField(controller: _phoneNumber,decoration: InputDecoration(filled: true,fillColor: Colors.white,hintText: /*"Phone Number"*/"Téléphone",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),keyboardType: TextInputType.number,),
                    SizedBox(height: 10,),
                    TextField(controller: _password,decoration: InputDecoration(filled: true,fillColor: Colors.white,hintText: /*"Password"*/"Mot de passe",border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(20)) )),obscureText: true,),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: InkWell(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              splashColor: Colors.white,
                              onTap: () async {
    isLoading=true;
    setState(() {

    });

    if(_phoneNumber.text==null||_phoneNumber.text==""||_password.text==""||_password.text==null){

    Fluttertoast.showToast(msg: "Phone Number and Password Required");

    }else {

                                await  http.post("http://mwinda-rdc.org/mobileapi/chat_user/register",
                                    body: {
                                      'phone':_phoneNumber.text.toString(),
                                      'username':_name.text.toString(),
                                      'password':_password.text.toString(),
                                      'api':"hj4xUON83bXWPZK85Ihn"
                                    }).then((response) async {
                                  var parsedJson = jsonDecode(response.body);

                                  if(parsedJson['success']==true)
                                  {_sharedPreferences=await SharedPreferences.getInstance();
                                  Global.Uid=_phoneNumber.text.toString();
                                  _sharedPreferences.setString('uid', Global.Uid);
                                  _sharedPreferences.setString('name', _name.text.toString());

                                  Global.Username=_name.text.toString();


                                  bool reg = false ;

                                  await Firestore.instance.collection('users').document(_phoneNumber.text.toString()).get().then(
                                          (ds){
                                        if( ds.data==null){
                                          reg =false;
                                        }else{
                                          reg=true;
                                        }
                                      }
                                  )
                                  ;

                                  if(reg)
                                  {
                                    print("Already Registered");

                                  }else {
                                    Firestore.instance.collection('users')
                                        .document(_phoneNumber.text.toString())
                                        .setData({
                                      'name':_name.text.toString(),
                                      'phone':_phoneNumber.text.toString()
                                    });
                                    print("New Registration");
                                  }
                                  Navigator.of(context).pushNamed('chat');


                                  Navigator.of(context).pushNamed('usersList');
                                  }else{

                                  }
                                  // Fluttertoast.showToast(msg: response.body);
                                  print(response.body);
                                });
    }
    isLoading = false;
    setState(() {

    });

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(child: isLoading?CircularProgressIndicator(backgroundColor: Colors.white,valueColor:new AlwaysStoppedAnimation<Color>(Global.MainColor),):Text(/*"Register"*/"S'inscrire",style: TextStyle(color: Colors.white,fontSize: 18),)),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(onTap:(){ Navigator.of(context).pushNamed('login');},
                  child: Text(/*"Already Have an Account, Click to Login "*/"Déjà inscrit, se connecter ici",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ,
              SizedBox(height: 30,)

            ],
          ),
        ),
      ),
    );
  }
}
