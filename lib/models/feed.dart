import 'package:final_mwinda_app/models/user.dart';
import 'package:final_mwinda_app/utils/utils.dart';

class Feed {
  int id, userId;
  String createdAt;
  String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id neque libero. Donec finibus sem viverra.';
  String bannerImg = AvailableImages.postBanner['assetPath'];
  String userName, userImage;

  Feed(this.id, this.createdAt, this.userId, this.userName, this.userImage);
}
