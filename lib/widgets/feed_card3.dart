import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/models/rubrique.dart';

class FeedCard3 extends StatelessWidget {
  final Rubrique rubrique;

  const FeedCard3({Key key, this.rubrique}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var tag3 = rubrique.title;
    final rubriqueImage = Positioned(
      right: 0,
      top: 15.0,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, singlePostPageRoute,
            arguments: rubrique.id),
        child: Hero(
          tag: tag3,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(14.0),
            child: Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                image: DecorationImage(
                  image: AssetImage(rubrique.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final postDate = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );

    final userName = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );

    final descriptionText = Container(
      height: 80.0,
      child: Text(
        rubrique.description,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      ),
    );

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        postDate,
        userName,
        SizedBox(
          height: 5.0,
        ),
        descriptionText
      ],
    );

    return Container(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Material( 
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: GestureDetector(
                onTap:() => Navigator.pushNamed(
                  context, quizzHomePageRoute,
                  arguments: rubrique.id
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, right: 100.0, left: 20.0),
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: cardContent,
                ),
              )
            )
              /*              child: 
            ),*/
          ),
          rubriqueImage
        ],
      ),
    );
  }
}
