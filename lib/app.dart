
import 'package:final_mwinda_app/pages/chat/chat.dart';
import 'package:final_mwinda_app/pages/chat/createGroup.dart';
import 'package:final_mwinda_app/pages/chat/login.dart';
import 'package:final_mwinda_app/pages/chat/register.dart';
import 'package:final_mwinda_app/pages/chat/selectUser.dart';
import 'package:final_mwinda_app/pages/chat/usersList.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/_routing/router.dart' as router;
import 'package:final_mwinda_app/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mwinda App',
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      onGenerateRoute: router.generateRoute,
      initialRoute: splashScreenRoute,
      routes: {
        'login':(context)=>Login(),
        'chat':(context)=>Chat(),
        'register':(context)=>Register(),
        'usersList':(context)=>UsersList(),
        'createGroup':(context)=>CreateGroup(),
        'selectUsers':(context)=>SelectUsers(),
      },
    );
  }
}
