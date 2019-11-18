import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

export 'package:flutter_map/src/core/point.dart';
export 'package:flutter_map/src/geo/crs/crs.dart';
export 'package:flutter_map/src/geo/latlng_bounds.dart';
export 'package:flutter_map/src/layer/circle_layer.dart';
export 'package:flutter_map/src/layer/group_layer.dart';
export 'package:flutter_map/src/layer/layer.dart';
export 'package:flutter_map/src/layer/marker_layer.dart';
export 'package:flutter_map/src/layer/overlay_image_layer.dart';
export 'package:flutter_map/src/layer/polygon_layer.dart';
export 'package:flutter_map/src/layer/polyline_layer.dart';
export 'package:flutter_map/src/layer/tile_layer.dart';
export 'package:flutter_map/src/layer/tile_provider/tile_provider.dart';
export 'package:flutter_map/src/layer/tile_provider/mbtiles_image_provider.dart';
export 'package:flutter_map/src/plugins/plugin.dart';
import 'package:final_mwinda_app/models/centre.dart';


class MapScreen extends StatelessWidget {
  // Declare a field that holds the Post.
  final Centre centre;

  // In the constructor, require a Post.
  MapScreen({Key key, @required this.centre}) : super(key: key);

  Image getImage() {
    AssetImage assetImage = AssetImage("images/map-marker.png");
    Image image = Image(image: assetImage);
    return image;
  }

  Widget build(BuildContext context) {

    var lat = double.parse(this.centre.latitude);
    var long = double.parse(this.centre.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(this.centre.nom, style: TextStyle(color: Colors.white),),
      ),
      body:
      Container(
        child: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(lat, long),
            zoom: 16.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoiYXBwbXdpbmRhIiwiYSI6ImNrMTJ6ZW0wbzAzdTgzb29hbXczcGkwazkifQ.wzgSA1yZHNWjiMBMpEur3g',
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 40.0,
                  height: 40.0,
                  point: new LatLng(lat, long),
                  builder: (ctx) =>
                  new Container(
                    child: getImage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );

  }

  double boxesWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}