import 'zonecenter.dart';

class Centre {
  int id;
  String name;
  String type;
  String appartenance;
  String address;
  String phone;
  double longitute;
  double latitude;
  ZoneCenter zone;

//
//  "id": "1",
//  "centre": "HOPITAL GENERAL DE REFERENCE DE KINKOLE ",
//  "type": "Formation sanitaire",
//  "appartenance": "etat",
//  "adresse": "AV/HOPITAL N°1 ",
//  "phone": "815178554",
//  "longitude": "15.5060857",
//  "latitude": "-4.346692",
//  "provinces": "Kinshasa",
//  "zones": "Nsele"

  Centre({this.id, this.name, this.address, this.appartenance, this.latitude,
    this.longitute, this.phone, this.zone, this.type});
}
