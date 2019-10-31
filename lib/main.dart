import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_mwinda_app/utils/colors.dart';
import 'package:final_mwinda_app/app.dart';

var routes = <String, WidgetBuilder>{
  //"/home": (BuildContext context) => HomeScreen(),
  //"/intro": (BuildContext context) => IntroScreen(),
};

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryDark
  ));
  runApp(App());
}

/*void main() => runApp(new MaterialApp(
    theme:
        ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes
));*/
