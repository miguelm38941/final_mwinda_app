
import 'package:final_mwinda_app/utils/utils.dart';

class Rubrique {
  int id;
  String title;
  String description = '';
  String bannerImg = AvailableImages.postBanner['assetPath'];
  String image;

  Rubrique(this.id, this.title, this.image);
}

final List<Rubrique> rubriques = [
  Rubrique(1, 'Actualités', AvailableImages.rubriqActualites['assetPath']),
  Rubrique(2, 'Quizz', AvailableImages.rubriqQuizz['assetPath']),
  Rubrique(3, 'Les centres', AvailableImages.rubriqCentres['assetPath']),
  Rubrique(4, 'Chat', AvailableImages.rubriqChat['assetPath']),
];/**/
