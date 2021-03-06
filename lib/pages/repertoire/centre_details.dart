import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/pages/repertoire/centre_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:final_mwinda_app/models/user.dart';
import 'package:final_mwinda_app/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:final_mwinda_app/pages/blog/post.dart';
import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';
import 'package:final_mwinda_app/utils/utils.dart';
import 'package:final_mwinda_app/models/centre.dart';
import 'dart:async';
import 'dart:convert';

class CentreDetailsPage extends StatelessWidget {
  final Centre centre;

  const CentreDetailsPage({Key key, this.centre}) : super(key: key);

  /*Future<Post> fetchPost() async {
    //debugPrint('000000000000000000');
    var response =
        await http.get('https://www.mwinda-rdc.org/mobileapi/blog/posts/120');
    //debugPrint("11111111111");
    var post = json.decode(response.body);
    //debugPrint("2222222" + dataDecoded.toString());

    if (response.statusCode == 200) {
      debugPrint("444444" + post.toString());
      return new Post(int.parse(post['id']), post['title'], post['category'],
          post['article'], post['image']);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final User user = users.singleWhere((user) => user.id == 120);
    debugPrint('THEID ' + this.centre.adresse);
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final cancelBtn = Positioned(
      top: 50.0,
      left: 20.0,
      child: Container(
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(LineIcons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          iconSize: 20.0,
        ),
      ),
    );

    final userImage = Stack(
      children: <Widget>[
        Hero(
          tag: AvailableImages.rubriqActualites['assetPath'],
          child: Container(
            height: 50.0,
            width: deviceWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(AvailableImages.rubriqActualites['assetPath']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        cancelBtn
      ],
    );

    final hobbies = Padding(
      padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(15.0),
          width: deviceWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          constraints: BoxConstraints(minHeight: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text(
                "", //"HOBBIES",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Display Post image
        Stack(
          children: <Widget>[
            Hero(
              tag: AvailableImages.rubriqChat['assetPath'],
              child: Container(
                height: 250.0,
                width: deviceWidth,
                child: new Image.asset('assets/images/rubriq_centres.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            cancelBtn
          ],
        ),
        // Display post title
        Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: new Text(
                    StringUtils.capitalize(this.centre.nom), //user.name,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                /*Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  height: 30.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      gradient: chatBubbleGradient,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          LineIcons
                              .mars, //user.gender == 'M' ? LineIcons.mars : LineIcons.venus,
                          color: Colors.white,
                        ),
                        Text(
                          '28', //user.age.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ),
                )*/
              ],
            )),
        // Display post category
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            this.centre.type,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue, //Colors.grey.withOpacity(0.8),
            ),
          ),
        ),
        // Display Post content
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(12.0),
            shadowColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(15.0),
              width: deviceWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              constraints: BoxConstraints(minHeight: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Appartenance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    StringUtils.capitalize(this.centre.appartenance),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "Adresse",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  _buildInfoDisplay(this.centre.adresse),
                  Text(
                    "Contact",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  _buildInfoDisplay(this.centre.phone),
                  _buildMapButton(this.centre, context, deviceWidth)
                ],
              ),
            ),
          ),
        ),
        //hobbies
      ],
    )));
  }

  Widget _buildInfoDisplay(data) {
    var display = (data != null)  ? data : "- - - ";
    
    return Text(
      display,
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildMapButton(centre, context, deviceWidth) {
    if ((centre.latitude != null) && (centre.longitude != null)) {
      return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        width: deviceWidth,
        child: new RaisedButton(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          color: Colors.lightBlue,
          onPressed: () => Navigator.pushNamed(context, mapPageRoute,
              arguments: this.centre),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(Icons.map, color: Colors.white),
              new Text(
                'Afficher la localisation',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        width: deviceWidth,
        child: Text(
          'Localisaion bientôt disponible',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        )
    );
  }

  Widget _buildHobbiesCards(String name) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      margin: EdgeInsets.only(right: 5.0, bottom: 3.0),
      height: 30.0,
      constraints: BoxConstraints(maxWidth: 80.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.transparent,
        border: Border.all(color: Colors.grey, width: 2.0),
      ),
      child: Center(
          child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      )),
    );
  }
}
