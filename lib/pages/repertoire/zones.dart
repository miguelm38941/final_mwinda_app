
import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/models/province.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:final_mwinda_app/models/quizz_theme.dart';
import 'package:final_mwinda_app/widgets/quizz/quiz_options.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ZonesPage extends StatelessWidget {
  final String provinceId;

  const ZonesPage({Key key, this.provinceId}) : super(key: key);

  Future<List<Province>> getZonesList() async {
    debugPrint('000000000000000000' + this.provinceId);
    var response = await http.get('https://www.mwinda-rdc.org/mobileapi/zones/liste/' + this.provinceId);
    debugPrint("11111111111");
    var dataDecoded = json.decode(response.body);
   // debugPrint("2222222" + dataDecoded['result'].toString());

    List<Province> zones_list = List();

    if (response.statusCode == 200) {
      dataDecoded['result'].forEach((theme){
      //debugPrint("3333333" + theme.toString());

        String nom = theme['zones'];
        if (nom != null) {
        if(nom.length>25){
          nom = theme['zones'].substring(1,25) + "...";
        }
        //String body = theme['article'].replaceAll(RegExp(r'\n'), " ");

          zones_list.add(new Province(int.parse(theme['id']), nom));
        }/**/
      });
      //debugPrint("444444" + posts.toString());
      zones_list.sort((Province a, Province b) => a.nom.compareTo(b.nom));
      return zones_list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement des articles');
    }


  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Trouver un centre'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/women_educ.jpg'),
                  fit: BoxFit.cover
                ),
              ),
              height: 200,
            ),
          ),
          Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  child: Text(
                    "Les zones", 
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0
                    ),
                  ),
                ),
          ),
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
            child: FutureBuilder(
                future: getZonesList(),
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
                          padding: EdgeInsets.only(top:0.0, bottom:0.0, left:16.0, right:16.0),
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(context, centresPageRoute, arguments: snapshot.data[index].id.toString()),
                            child: Hero(
                              tag: snapshot.data[index].nom,
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(0.0),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                    child: AutoSizeText(
                                      snapshot.data[index].nom,
                                      minFontSize: 18.0,
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