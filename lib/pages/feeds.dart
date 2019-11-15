import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:final_mwinda_app/widgets/feed_card1.dart';
import 'package:final_mwinda_app/widgets/feed_card2.dart';
import 'package:final_mwinda_app/widgets/feed_card3.dart';
import 'package:final_mwinda_app/_routing/routes.dart';

import '../utils/utils.dart';

class FeedsPage extends StatelessWidget {

  Widget _genMenuItem(int id,context,routeName){
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(3.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.lightBlue.withOpacity(0.7),
        child: InkWell(
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.lightBlueAccent,
          hoverColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, routeName,
              arguments: rubriques[id].id);
          },
          child: Container(
            child: ListTile(
              title: Text(rubriques[id].title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                  //fontStyle: FontStyle.italic,

                ),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(rubriques[id].image),
              ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
      child: Text(
        "Bienvenue sur Mwinda",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30.0,
        ),
      ),
    );

    return Scaffold(
      /*appBar: AppBar(
        title: Text("Information", style: TextStyle(color: Colors.white),),
      ),*/
      drawer: Drawer(

        child: Container(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(14.0),
                  color: Colors.lightBlue,
//                image: DecorationImage(
//                  image: AvailableImages.unescoLogo,
//                  fit: BoxFit.scaleDown,
//                ),
                ),
              ),

              _genMenuItem(0,context,postsPageRoute),
              _genMenuItem(1,context,singlePostPageRoute),
              _genMenuItem(2,context, provinceViewRoute),
              _genMenuItem(3,context,postsPageRoute),

            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Mwinda",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              backgroundColor: Colors.transparent
              //fontSize: 14.0,
              ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                color: Colors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    /*FeedCard1(feed: feeds[0]),
                    SizedBox(
                      height: 10.0,
                    ),*/
                    FeedCard2(
                      rubrique: rubriques[0],
                      routeName: postsPageRoute,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FeedCard3(
                      rubrique: rubriques[1],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FeedCard2(
                      rubrique: rubriques[2],
                      routeName: provinceViewRoute,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FeedCard3(
                      rubrique: rubriques[3],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
