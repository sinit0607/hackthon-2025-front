import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:codesapp/app/modules/notification/views/notification_view.dart';
import 'package:codesapp/app/modules/profile/views/profile_view.dart';
import 'package:codesapp/app/modules/search_shorts/views/search_shorts_view.dart';
import 'package:codesapp/app/modules/shorts/views/shorts_view.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  int _count = 0;

  int get count => _count;

  set count(int value) {
    _count = value;
    update();
  }

  List screenList = [
    ShortsView(),
    SearchShortsView(),
    NotificationsPage(),
    ProfileView()
  ];

  final sidebarXController = SidebarXController(selectedIndex: 0);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
