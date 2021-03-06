import 'package:final_mwinda_app/pages/chat/login.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:page_transition/page_transition.dart';

class ChatCard extends StatelessWidget {
  final Rubrique rubrique;

  const ChatCard({Key key, this.rubrique}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var tag3 = rubrique.title;
    final rubriqueImage = Positioned(
      right: 0,
      top: 15.0,
      child: InkWell(
        /*onTap: () => Navigator.pushNamed(context, quizzHomePageRoute,
            arguments: rubrique.id),*/
        onTap:() => Navigator.of(context).pushNamed('login'),
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
        color: Colors.grey.withOpacity(0.0),
        fontWeight: FontWeight.bold,
      ),
    );

    final rubriqueTitle = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    );

    final descriptionText = Container(
      height: 80.0,
      child: Text(
        rubrique.description,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      ),
    );

    final cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        postDate,
        rubriqueTitle,
        SizedBox(
          height: 5.0,
        ),
        descriptionText
      ],
    );

    return Container(
      height: 155.0, // Hauteur de la carte
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Material( 
              elevation: 5.0,
              borderRadius: BorderRadius.circular(14.0),
              child: GestureDetector(
                /* INSERT CHAT LINK */
                /*onTap:() => Navigator.pushNamed(
                  context, quizzHomePageRoute,
                  arguments: rubrique.id
                ),*/
                onTap: () => Navigator.push(
                  context,               
                  PageTransition(
                    type: PageTransitionType.scale, 
                    alignment: Alignment.bottomCenter, 
                    duration: Duration(milliseconds: 1000),
                    child: Login()
                  )
                ),                    
                //onTap:() => Navigator.of(context).pushNamed('login'),
                /* END OF INSERT CHAT LINK */
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, right: 80.0, left: 20.0),
                  height: 155.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[800],
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
