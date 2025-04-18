import 'package:get/get.dart';
import 'package:codesapp/app/data/components/config.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
