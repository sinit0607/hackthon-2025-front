import 'package:get/get.dart';

import '../controllers/shorts_controller.dart';

class ShortsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortVideoController>(
      () => ShortVideoController(),
    );
  }
}
