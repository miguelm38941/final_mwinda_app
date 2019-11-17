import 'package:final_mwinda_app/utils/utils.dart';

class User {
  int id;
  String name;
  String photo;
  String location = 'Seattle, USA.';
  String gender;
  int age;

  User(this.id, this.name, this.photo, this.gender, this.age);
}


// Names generated at http://random-name-generator.info/
final List<User> users = [
  //User(115, 'Matt Maxwell', AvailableImages.man1['assetPath'], 'M', 27),
];

final List<String> userHobbies = [
  "Dancing", "Hiking", "Singing", "Reading", "Fishing"
]; 
