import 'package:flutter/material.dart';
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:flip_card/flip_card.dart';
import 'package:soundpool/soundpool.dart';

class QuizzCard extends StatelessWidget {
  final Rubrique rubrique;

  const QuizzCard({Key key, this.rubrique}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final postDate = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
      ),
    );

    final rubriqueTitle = Text(
      rubrique.title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 35.0,
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
        rubriqueTitle,
        SizedBox(
          height: 5.0,
        ),
        descriptionText
      ],
    );

    final rubriqueImage = Positioned(
      left: 0,
      bottom: 0,
      child: new Opacity(
        opacity: 0.5,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, quizzHomePageRoute,
              arguments: rubrique.id),
          child: Hero(
            tag: rubrique.title,
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(0),
              child: Container(
                color: Colors.black,
                  height: 70.0,
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  child: new Opacity(
                    opacity: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        rubriqueTitle,
                        SizedBox(
                          height: 5.0,                        
                        ),
                      ],
                    ),
                  )
              ),
            )
          ),
        ),
      ),
    );

    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    return Container(
      height: 200.0, // Hauteur de la carte
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Material(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, quizzHomePageRoute,
                    arguments: rubrique.id),
                child: FlipCard(
                  key: cardKey,
                  flipOnTouch: false,
                  front: Container(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(rubrique.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: GestureDetector(
                      onTap: () => cardKey.currentState.toggleCard(),
                      child: Container(
                        child: Text(''),
                      ),

                    )
                    
                  ),
                  back: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Center(
                      child:Text(
                        'LE QUIZZ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 45.0,
                        ),
                      ),

                    ),
                  ),
                ),
              ),
              elevation: 5.0,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          rubriqueImage
        ],
      ),
    );
  }
}
