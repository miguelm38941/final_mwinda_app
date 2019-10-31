import 'package:flutter/material.dart';
import 'package:final_mwinda_app/utils/colors.dart';
//import 'package:line_icons/line_icons.dart';
import 'package:final_mwinda_app/pages/feeds.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    FeedsPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],
    );
  }
}
