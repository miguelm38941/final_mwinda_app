import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';
//import 'package:phone_number/phone_number.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences _sharedPreferences;


  chkUser() async {

    _sharedPreferences =await SharedPreferences.getInstance();

    String uid = await _sharedPreferences.getString('uid');

    if(uid==null){
      startTimeout();
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

  }

  static const timeout = const Duration(seconds: 3);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {  // callback function
    Navigator.of(context).pushNamed('login');
  }

  void getMyPhone(){

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkpermissions();
  chkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Global.MainColor,
        child: Center(child: GestureDetector(onTap: (){
        },child: Text("SplashScreen")),),
      ),
    );
  }
}
