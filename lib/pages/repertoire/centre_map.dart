import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:final_mwinda_app/models/centre.dart';


class centreMapPage extends  StatelessWidget {
  // Declare a field that holds the Post.
  final Centre centre;

  // In the constructor, require a Post.
  centreMapPage({Key key, @required this.centre}) : super(key: key);

  Image getImage() {
    AssetImage assetImage = AssetImage("images/map-marker.png");
    Image image = Image(image: assetImage);
    return image;
  }

  Widget build(BuildContext context) {

    var lat = double.parse(this.centre.latitude);
    var long = double.parse(this.centre.longitude);
    debugPrint(lat.toString()+' - '+long.toString());
    return new Scaffold(
        appBar: new AppBar(title: new Text(this.centre.nom)),
        body: new FlutterMap(
            options: new MapOptions(
                center: new LatLng(lat, long), minZoom: 15.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/rajayogan/cjl1bndoi2na42sp2pfh2483p/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXBwbXdpbmRhIiwiYSI6ImNrMTJ6ZW0wbzAzdTgzb29hbXczcGkwazkifQ.wzgSA1yZHNWjiMBMpEur3g",
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1IjoiYXBwbXdpbmRhIiwiYSI6ImNrMTJ6ZW0wbzAzdTgzb29hbXczcGkwazkifQ.wzgSA1yZHNWjiMBMpEur3g',
                    'id': 'mapbox.mapbox-streets-v7'
                  }),
              new MarkerLayerOptions(markers: [
                new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(lat, long),
                    builder: (context) => new Container(
                          child: IconButton(
                            icon: Icon(Icons.location_on),
                            color: Colors.blue,
                            iconSize: 45.0,
                            onPressed: () {
                              print('Marker tapped');
                            },
                          ),
                        ))
              ])
            ]));

  }

  double boxesWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}
