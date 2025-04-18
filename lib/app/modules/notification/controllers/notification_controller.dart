// lib/modules/notifications/controllers/notifications_controller.dart
import 'package:get/get.dart';

import '../../../data/repos/notification_service.dart';
import '../../../data/response_model/notification_model.dart';

class NotificationsController extends GetxController {
  final NotificationService _notificationService = NotificationService();

  // Observable list of notifications
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error state
  final Rx<String?> error = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Fetch notifications
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final fetchedNotifications = await _notificationService.getNotifications();
      notifications.value = fetchedNotifications;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load notifications',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Getters for different notification types
  List<NotificationModel> get followRequests =>
      notifications.where((n) => n.type == NotificationType.followRequest).toList();

  List<NotificationModel> get newNotifications =>
      notifications.where((n) => n.timestamp.contains('m')).toList();

  List<NotificationModel> get todayNotifications =>
      notifications.where((n) => !n.username.contains('riya')).toList();

  // Handle notification tap
  void onNotificationTap(NotificationModel notification) {
    // Mark as read
    notification.isRead.value = true;

    // Navigation or action based on notification type
    switch (notification.type) {
      case NotificationType.followRequest:
        Get.toNamed('/follow-requests');
        break;
      case NotificationType.like:
      case NotificationType.comment:
      // Navigate to specific post
        Get.toNamed('/post/${notification.id}');
        break;
      case NotificationType.mention:
      case NotificationType.follow:
      // Navigate to user profile
        Get.toNamed('/profile/${notification.username}');
        break;
    }
  }

  // Handle follow requests
  void onFollowRequestsTap() {
    Get.toNamed('/follow-requests');
  }
}