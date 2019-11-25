import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/widgets/quizz/quiz_options.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:final_mwinda_app/models/question.dart';
import 'package:final_mwinda_app/resources/api_provider.dart';
import 'package:final_mwinda_app/pages/quizz/error.dart';
import 'package:final_mwinda_app/pages/quizz/quiz_page.dart';

class QuizzHomePage extends StatelessWidget {
  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ];


  Future<List<QuizzTheme>> getThemesList() async {
    //debugPrint('000000000000000000');
    var response = await http.get('https://www.mwinda-rdc.org/mobileapi/quizz/getall');
    //debugPrint("11111111111");
    var dataDecoded = json.decode(response.body);
    //debugPrint("2222222" + dataDecoded['result'].toString());

    List<QuizzTheme> themes = List();

    if (response.statusCode == 200) {
      dataDecoded['result'].forEach((theme){
      //debugPrint("3333333" + theme.toString());

        String titre = theme['theme'];
        if(titre.length>25){
          titre = theme['theme'].substring(1,25) + "...";
        }
        //String body = theme['article'].replaceAll(RegExp(r'\n'), " ");
        if (titre != null) {
          themes.add(new QuizzTheme(int.parse(theme['id']), titre));
        }/**/
      });
      //debugPrint("444444" + posts.toString());
      return themes;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }


  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 3.0,
        title: new Text(
          "Mwinda Quizz",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/children_educ.jpg'),
                  fit: BoxFit.fitHeight
                ),
              ),
              height: 600,
            ),
          ),
          Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  child: Text(
                    "Choisissez un thème", 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 40.0
                    ),
                  ),
                ),
            
          ),
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
            child: FutureBuilder(
                future: getThemesList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 60.0, bottom: 60.0),//.all(0.0),
                      scrollDirection: Axis.vertical,
                      primary: true,
                      itemCount: snapshot.data.length, //data.length,
                      itemBuilder: (BuildContext content, int index) {    
                        return Container(
                          padding: EdgeInsets.only(top:5.0, bottom:5.0, left:16.0, right:16.0),
                          child: InkWell(
                            onTap:  () => _categoryPressed(context, snapshot.data[index]), //() => Navigator.pushNamed(context, homePageRoute, arguments: 11),
                            child: Hero(
                              tag: snapshot.data[index].theme,
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(14.0),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                    child: AutoSizeText(
                                      snapshot.data[index].theme,
                                      minFontSize: 25.0,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                      wrapWords: false,
                                    ),
                                )
                              )
                            )
                          )
                        );
                      }
                    );
                  }
                  return Align(
                    alignment: FractionalOffset.center,
                    child: CircularProgressIndicator(),
                  );
                }               
              )

          )

        ],
      )
    );
  }




 
  /*Widget _buildCategoryItem(BuildContext context, int index) {
    Category category = categories[index];
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => homePageRoute, //_categoryPressed(context,category),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey.shade800,
      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if(category.icon != null)
            Icon(category.icon),
          if(category.icon != null)
            SizedBox(height: 5.0),
          AutoSizeText(
            category.name,
            minFontSize: 10.0,
            textAlign: TextAlign.center,
            maxLines: 3,
            wrapWords: false,
          ),
        ],
      ),
    );
  }
*/
  _categoryPressed(BuildContext context, QuizzTheme quizzTheme) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(quizzTheme: quizzTheme,),
        onClosing: (){},

      ),
      
    );

  }
}