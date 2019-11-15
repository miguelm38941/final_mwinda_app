import 'package:final_mwinda_app/pages/centre/zoneView.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:final_mwinda_app/models/province.dart';
import 'package:final_mwinda_app/utils/utils.dart';

class ProvincePage extends StatefulWidget {
  ProvincePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProvincePageState createState() => new _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 1,
        title: new Text(
          "Provinces",
          //widget.title != null ? widget.title : '',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: show(),
          builder: (context, data) {
            if (data.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 60.0), //.all(0.0),
                  scrollDirection: Axis.vertical,
                  primary: true,
                  itemCount: data.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(data.data[index].name),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,size: 30.0,
                        ),
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
                          child: Icon(Icons.location_city, color: Colors.lightBlueAccent,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ZonePage(
                                    province: data.data[index],
                                  )));
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

  Future<List<Province>> show() async {
    //debugPrint('${BASE_URL}/provinces/liste');

    var response = await http.get('${BASE_URL}/provinces/liste');

    //debugPrint(response.body);

    var dataDecoded = json.decode(response.body);

    //debugPrint("\n\nWe are here--${dataDecoded['result']}");
    List<Province> items = List();

    if (response.statusCode == 200) {
      dataDecoded['result'].forEach((item) {
        //debugPrint("We are here--${item}");
        //var province= Province(item['id'], item['provinces']);
        items.add(new Province(int.parse(item['id']), item['provinces']));
      });
      //debugPrint("We are here--${items}");
      return items;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Echec du chargement');
    }
  }
}
