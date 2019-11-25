import 'package:final_mwinda_app/pages/repertoire/centre_map.dart';
import 'package:final_mwinda_app/pages/repertoire/map_screen.dart';
import 'package:final_mwinda_app/utils/sizeRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/pages/home_page.dart';
import 'package:final_mwinda_app/pages/quizz/quizz_home.dart';
import 'package:final_mwinda_app/pages/splash_screen.dart';
import 'package:final_mwinda_app/pages/blog/blog.dart';
import 'package:final_mwinda_app/pages/blog/post_details.dart';
import 'package:final_mwinda_app/pages/repertoire/provinces.dart';
import 'package:final_mwinda_app/models/province.dart';
import 'package:final_mwinda_app/pages/repertoire/centres.dart';
import 'package:final_mwinda_app/pages/repertoire/centre_details.dart';
import 'package:final_mwinda_app/pages/repertoire/zones.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case quizzHomePageRoute:
      return MaterialPageRoute(builder: (context) => QuizzHomePage());
    case homePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case postsPageRoute:
      return SizeRoute(page: BlogPage());
      //return CupertinoPageRoute(builder: (context) => BlogPage());
      //return MaterialPageRoute(builder: (context) => BlogPage());
    case singlePostPageRoute:
      return MaterialPageRoute(builder: (context) => PostDetailsPage(postId: settings.arguments));
    case provincesPageRoute:
      return MaterialPageRoute(builder: (context) => ProvincesPage());
    case zonesPageRoute:
      return MaterialPageRoute(builder: (context) => ZonesPage(provinceId: settings.arguments));
    case centresPageRoute:
      return MaterialPageRoute(builder: (context) => CentresPage(zoneId: settings.arguments));
    case centreDetailPageRoute:
      return MaterialPageRoute(builder: (context) => CentreDetailsPage(centre: settings.arguments));
    case mapViewRoute:
      return MaterialPageRoute(builder: (context) => MapScreen(centre: settings.arguments));
    case mapPageRoute:
      return MaterialPageRoute(builder: (context) => centreMapPage(centre: settings.arguments));
    default:
      return MaterialPageRoute(builder: (context) => SplashScreen());
  }
}
