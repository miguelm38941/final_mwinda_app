
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_mwinda_app/utils/colors.dart';
import 'package:final_mwinda_app/app.dart';


import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


var routes = <String, WidgetBuilder>{
  //"/home": (BuildContext context) => HomeScreen(),
  //"/intro": (BuildContext context) => IntroScreen(),
};

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  //await DatabaseCreator().initDatabase();
  runApp(App());
}