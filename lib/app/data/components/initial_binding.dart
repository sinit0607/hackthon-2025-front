import 'package:get/get.dart';
import 'package:codesapp/app/modules/home/controllers/home_controller.dart';
import 'package:codesapp/app/modules/profile/controllers/profile_controller.dart';
import 'package:codesapp/app/modules/search_shorts/controllers/search_shorts_controller.dart';
import 'package:codesapp/app/modules/shorts/controllers/shorts_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchShortsController());
    Get.lazyPut(() => ShortVideoController());
    Get.lazyPut(() => ProfileController());

  }
}
