import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/pages/home.dart';
import 'package:final_mwinda_app/pages/landing.dart';
import 'package:final_mwinda_app/pages/feeds.dart';
import 'package:final_mwinda_app/pages/splash_screen.dart';
import 'package:final_mwinda_app/pages/blog.dart';
import 'package:final_mwinda_app/pages/blog/post_details.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case feedsPageRoute:
      return MaterialPageRoute(builder: (context) => FeedsPage());
    case postsPageRoute:
      return MaterialPageRoute(builder: (context) => MyHomePage());
    case singlePostPageRoute:
      return MaterialPageRoute(builder: (context) => PostDetailsPage());
    case splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
