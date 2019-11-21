import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  SharedPreferences _sharedPreferences;

  TextEditingController textEditingController = new TextEditingController();
  TextEditingController _phoneNumber = new TextEditingController();
  TextEditingController _password = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpermissions();

  }

  chkUser() async {

    _sharedPreferences =await SharedPreferences.getInstance();

    String uid = await _sharedPreferences.getString('uid');

    if(uid==null){
     // Navigator.of(context).pushNamed('login');
    }else
    {

      print(uid);

      Global.Uid=uid;
      Global.Username=_sharedPreferences.getString('name')??"Developer";
      Navigator.of(context).pushReplacementNamed('usersList');
    }
  }


  checkpermissions() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);
    permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if(permission == PermissionStatus.granted){

    }else
    {

      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.microphone,PermissionGroup.storage]);

    }

    chkUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            //   image: DecorationImage(image: AssetImage('assets/bg.jpg'),fit: BoxFit.cover)
            color: Global.MainColor),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: /*"Phone Number"*/"Téléphone",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _password,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: /*"Password"*/"Mot de passe",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              splashColor: Colors.red,
                              onTap: () async {
                                isLoading=true;
                                setState(() {

                                });

                                if(_phoneNumber.text==null||_phoneNumber.text==""||_password.text==""||_password.text==null){

                                  Fluttertoast.showToast(msg: "Phone Number and Password Required");

                                }else {
                                  await http.post(
                                      "http://mwinda-rdc.org/mobileapi/chat_user/login",
                                      body: {
                                        'phone': _phoneNumber.text.toString(),
                                        'password': _password.text.toString(),
                                        'api': "hj4xUON83bXWPZK85Ihn"
                                      }).then((response) async {
                                    //      Fluttertoast.showToast(msg: response.body);
                                    var parsedJson = jsonDecode(response.body);

                                    if (parsedJson['success'] == true) {
                                      _sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      Global.Uid = _phoneNumber.text.toString();
                                      _sharedPreferences.setString(
                                          'uid', Global.Uid);
                                      _sharedPreferences.setString(
                                          'name', parsedJson['username']);
                                      Global.Username =
                                      parsedJson['result']['username'];
                                      Navigator.of(context)
                                          .pushNamed('usersList');
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Invalid ID or Password");
                                    }
                                    print(response.body);


                                  });
                                }
                                isLoading = false;
                                setState(() {

                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                    child: isLoading?CircularProgressIndicator(backgroundColor: Colors.white,valueColor:new AlwaysStoppedAnimation<Color>(Global.MainColor),):Text(
                                  /*"Login"*/"Connexion",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('register');
                  },
                  child: Text(
                    /*"Don't Have Account Click to Create One "*/"Pas de compte ? s'inscrire",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*


bool reg = false ;

await Firestore.instance.collection('users').document(textEditingController.text).get().then(
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
    .document(textEditingController.text)
    .setData({});
print("New Registration");
}
Navigator.of(context).pushNamed('chat');*/
