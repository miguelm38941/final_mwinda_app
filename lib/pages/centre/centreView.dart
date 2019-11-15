import 'package:final_mwinda_app/models/centre.dart';
import 'package:final_mwinda_app/models/zonecenter.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_mwinda_app/models/zonecenter.dart';
import 'package:final_mwinda_app/utils/utils.dart';

class CentersPage extends StatefulWidget {
  CentersPage({Key key, this.title, @required this.zone}) : super(key: key);

  final String title;
  final ZoneCenter zone;

  @override
  _CentersPageState createState() => new _CentersPageState(zone);
}

class _CentersPageState extends State<CentersPage> {
  final ZoneCenter zone;
  _CentersPageState(this.zone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 1,
        title: new Text(
          "Centres(${this.zone.name})",
          //widget.title != null ? widget.title : '',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: show(),
          builder: (context, data) {
            if (data.hasData) {
              debugPrint("We are here--${data.data}");


              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0), //.all(0.0),
                  scrollDirection: Axis.vertical,
                  primary: true,
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
                      elevation: 2.0,
                      child: ListTile(
                        title: Container(
                          child: Column(
                            children: <Widget>[
                              Text(data.data[index].name),
                             Container(
                               margin: EdgeInsets.symmetric(vertical: 8.0),
                               child:  Row(
                                 children: <Widget>[
                                   Icon(Icons.phone),
                                   Text(data.data[index].phone)
                                 ],
                               ),
                             )
                            ],
                          ),
                        ),
                        subtitle: Text(data.data[index].address) ,
                        leading: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0,
                                      color: Colors.lightBlue
                                  )
                              )
                          ),
                          child: Icon(Icons.location_on, color: Colors.lightBlueAccent,
                          ),
                        ),
                        onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) =>
//                                  CentersPage(zone: data.data[index])));
                        },
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('${data.error}'), //"Une erreur s'est produite"),
              );
            }
          }),
    );
  }

  Future<List<Centre>> show() async {
    //debugPrint('${BASE_URL}/provinces/liste');

    var response =
        await http.get('${BASE_URL}/centre_depistage/liste/${zone.id}');

    //debugPrint(response.body);

    var dataDecoded = json.decode(response.body);

    //debugPrint("\n\nWe are here--${dataDecoded['result']}");
    List<Centre> items = List();

    if (response.statusCode == 200) {
      dataDecoded['result'].forEach((item) {
        debugPrint("We are here--${item['latitude']}");
        //var province= Province(item['id'], item['provinces']);

//        "id": "1",
//        "centre": "HOPITAL GENERAL DE REFERENCE DE KINKOLE ",
//        "type": "Formation sanitaire",
//        "appartenance": "etat",
//        "adresse": "AV/HOPITAL N°1 ",
//        "phone": "815178554",
//        "longitude": "15.5060857",
//        "latitude": "-4.346692",
//        "provinces": "Kinshasa",
//        "zones": "Nsele"



        items.add(new Centre(
            id:int.parse(item['id']),
          address: item['adresse'].replaceAll(RegExp(r'\n'), " "),
          appartenance: item['appartenance'],
          type: item['type'],
          name: item['centre'],
          zone: zone,
          phone: item['phone'],
          latitude: item['latitude'] != null ? double.parse(item['latitude']):0.0,
          longitute: item['longitude'] != null ? double.parse(item['longitude']) : 0.0,
           )
        );
      });
      //debugPrint("We are here--${items}");
      return items;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement');
    }
  }
}
