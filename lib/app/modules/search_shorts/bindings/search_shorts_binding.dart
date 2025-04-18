import 'package:get/get.dart';

import '../controllers/search_shorts_controller.dart';

class SearchShortsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchShortsController>(
      () => SearchShortsController(),
    );
  }
}
