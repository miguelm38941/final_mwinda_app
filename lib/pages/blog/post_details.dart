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
import 'dart:async';
import 'dart:convert';

class PostDetailsPage extends StatelessWidget {
  final String userId = '120';

  //const PostDetailsPage({Key key, this.userId}) : super(key: key);



  Future<List<Post>> showPosts() async {
    //debugPrint('000000000000000000');
    var response = await http.get('https://www.mwinda-rdc.org/mobileapi/blog/posts/120');
    //debugPrint("11111111111");
    var post = json.decode(response.body);
    //debugPrint("2222222" + dataDecoded.toString());

    List<Post> posts = List();

    if (response.statusCode == 200) {

      //dataDecoded.forEach((post){
      //debugPrint("3333333" + post.toString());

        String title = post['title'];
        if(title.length>25){
          title = post['title']; //.substring(1,25) + "...";
        }
        String body = post['article'].replaceAll(RegExp(r'\n'), " ");
        if (post['image'] != null) {
          if(post['image'].contains('images') ) {
            posts.add(new Post(int.parse(post['id']), title, post['category'], body, post['image']));
          }
        } 
      //});
      debugPrint("444444" + post.toString());
      return post;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }
  }


  @override
  Widget build(BuildContext context) {
    //final User user = users.singleWhere((user) => user.id == 120);
 debugPrint('THEID 120');
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
          tag: AvailableImages.woman1['assetPath'],
          child: Container(
            height: 350.0,
            width: deviceWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AvailableImages.woman1['assetPath']),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        cancelBtn
      ],
    );

    final userName = Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: <Widget>[
            Text(
              'John Doe',//user.name,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
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
                      LineIcons.mars,//user.gender == 'M' ? LineIcons.mars : LineIcons.venus,
                      color: Colors.white,
                    ),
                    Text(
                      '28',//user.age.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));

    final userLocation = Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        'Seattle',//user.location,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.8),
        ),
      ),
    );

    final aboutUser = Padding(
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
                "ABOUT ME",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                "My name is .......... and i love meeting new people and making new friends. I love sports, reading, hiking and partying. Don't be reluctant to hit me up.",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      ),
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
                "HOBBIES",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Wrap(
                children: userHobbies
                    .map((hobby) => _buildHobbiesCards(hobby))
                    .toList(),
              )
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
            userImage,
            userName,
            userLocation,
            aboutUser,
            hobbies
          ],
        ),
      ),
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
