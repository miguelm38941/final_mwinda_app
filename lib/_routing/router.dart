import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/pages/home_page.dart';
import 'package:final_mwinda_app/pages/quizz/quizz_home.dart';
import 'package:final_mwinda_app/pages/splash_screen.dart';
import 'package:final_mwinda_app/pages/blog/blog.dart';
import 'package:final_mwinda_app/pages/blog/post_details.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case quizzHomePageRoute:
      return MaterialPageRoute(builder: (context) => QuizzHomePage());
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case postsPageRoute:
      return MaterialPageRoute(builder: (context) => BlogPage());
    case singlePostPageRoute:
      return MaterialPageRoute(builder: (context) => PostDetailsPage(postId: settings.arguments));
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
