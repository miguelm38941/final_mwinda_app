import 'createGroup.dart';
import 'register.dart';
import 'selectUser.dart';
import 'usersList.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'splashScreen.dart';
import 'login.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red
      ),
      home: SplashScreen(),
      routes: {
        'login':(context)=>Login(),
        'chat':(context)=>Chat(),
        'register':(context)=>Register(),
        'usersList':(context)=>UsersList(),
        'createGroup':(context)=>CreateGroup(),
        'selectUsers':(context)=>SelectUser()

      },
    );
  }
}
