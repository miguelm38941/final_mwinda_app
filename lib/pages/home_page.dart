import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:final_mwinda_app/widgets/feed_card1.dart';
import 'package:final_mwinda_app/widgets/blog_card.dart';
import 'package:final_mwinda_app/widgets/quizz_card.dart';
import 'package:final_mwinda_app/widgets/directory_card.dart';
import 'package:final_mwinda_app/widgets/chat_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
      child: Text(
        "Bienvenue sur Mwinda",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 40.0,
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
                    BlogCard(
                      rubrique: rubriques[0],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    QuizzCard(
                      rubrique: rubriques[1],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DirectoryCard(
                      rubrique: rubriques[2],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ChatCard(
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
