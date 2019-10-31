import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:final_mwinda_app/widgets/feed_card1.dart';
import 'package:final_mwinda_app/widgets/feed_card2.dart';
import 'package:final_mwinda_app/widgets/feed_card3.dart';

class FeedsPage extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
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
