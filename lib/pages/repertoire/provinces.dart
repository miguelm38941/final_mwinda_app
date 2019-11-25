import 'package:final_mwinda_app/_routing/routes.dart';
import 'package:final_mwinda_app/models/province.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProvincesPage extends StatelessWidget {

  Future<List<Province>> getProvincesList() async {
    //debugPrint('000000000000000000');
    var response = await http.get('https://www.mwinda-rdc.org/mobileapi/provinces/liste');
    //debugPrint("11111111111");
    var dataDecoded = json.decode(response.body);
    //debugPrint("2222222" + dataDecoded['result'].toString());

    List<Province> provinces_list = List();

    if (response.statusCode == 200) {
      dataDecoded['result'].forEach((theme){
      //debugPrint("3333333" + theme.toString());

        String nom = theme['provinces'];
        if(nom.length>25){
          nom = theme['provinces'].substring(1,25) + "...";
        }
        //String body = theme['article'].replaceAll(RegExp(r'\n'), " ");
        if (nom != null) {
          provinces_list.add(new Province(int.parse(theme['id']), nom));
        }/**/
      });
      //debugPrint("444444" + posts.toString());
      return provinces_list;
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
                    "Les provinces", 
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
                future: getProvincesList(),
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
                            onTap:  () => Navigator.pushNamed(context, zonesPageRoute, arguments: snapshot.data[index].id.toString()),
                            //() => _categoryPressed(context, snapshot.data[index]), //() => Navigator.pushNamed(context, homePageRoute, arguments: 11),
                            child: Hero(
                              tag: snapshot.data[index].nom,
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(0.0),
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                    child: AutoSizeText(
                                      snapshot.data[index].nom,
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


}