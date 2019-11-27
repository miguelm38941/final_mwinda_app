import 'package:final_mwinda_app/pages/chat/chat.dart';
import 'package:final_mwinda_app/pages/chat/login.dart';
import 'package:flutter/material.dart';
import 'package:final_mwinda_app/models/rubrique.dart';
import 'package:final_mwinda_app/widgets/feed_card1.dart';
import 'package:final_mwinda_app/widgets/blog_card.dart';
import 'package:final_mwinda_app/widgets/quizz_card.dart';
import 'package:final_mwinda_app/widgets/directory_card.dart';
import 'package:final_mwinda_app/widgets/chat_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';



final List<String> imgList = [
  'https://humanhist.com/wp-content/uploads/2018/06/unesco_hq_688px.jpg',
  'https://img.lemde.fr/2017/10/12/0/0/3500/2334/688/0/60/0/918353a_PAR01_UNESCO-ELECTION-USA_1012_11.JPG',
  'https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/assets/2016/06/24637/image1170x530cropped.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUM42Mk_6GPBN0uFg6GqwdFezRf-Md9GVnY4cCU7tN6hmDtHLJpQ&s',
  'https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/assets/2014/01/18510/image1024x768.jpg',
  'https://www.alwihdainfo.com/photo/art/grande/15462094-20756032.jpg'
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. $index image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}


class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _HomePageState extends State<HomePage> {
  // Whether the green box should be visible.
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // The green box goes here with some other Widgets.

    // Whether the green box should be visible
    bool _visible = true;

    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 0, bottom: 10.0),
      child: Text(
        "Bienvenue sur Mwinda",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue,
          fontSize: 20.0,
        ),
      ),
    );

    //Auto playing carousel
    final CarouselSlider autoPlayDemo = CarouselSlider(
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          return Container(
            margin: EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );

    //Pages covers entire carousel
    final CarouselSlider coverScreenExample = CarouselSlider(
      viewportFraction: 1.0,
      aspectRatio: 2.0,
      autoPlay: true,
      enlargeCenterPage: false,
      items: map<Widget>(
        imgList,
        (index, i) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Mwinda App", style: TextStyle(color: Colors.white),),
        leading: new Container(),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () => Navigator.push(
              context,               
              PageTransition(
                type: PageTransitionType.scale, 
                alignment: Alignment.bottomCenter, 
                duration: Duration(milliseconds: 500),
                child: Login()
              )
            ),                    
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          padding: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              autoPlayDemo,
              Container(
                padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                color: Colors.white,
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



/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
}*/
