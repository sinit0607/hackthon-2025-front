import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:codesapp/app/data/components/app_color.dart';

import '../../../data/components/custom_text.dart';
import '../controllers/notification_controller.dart';
import 'follow_requests_tile.dart';
import 'notification_tile.dart';

class NotificationsPage extends GetView<NotificationsController> {
  NotificationsPage({Key? key}) : super(key: key);

  NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlack,
      body: Stack(
        children: [
          ParticlesFly(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            connectDots: true,
            isRandomColor: false,
            numberOfParticles: 40,
            particleColor: AppColors.appWhite.withOpacity(0.4),
            lineColor: AppColors.appWhite.withOpacity(0.4),
          ),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _buildNotificationsList(),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return Obx(() {
      // Handle loading state
      if (notificationsController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Handle error state
      if (notificationsController.error.value != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(text: 'Failed to load notifications'),
              ElevatedButton(
                onPressed: () => notificationsController.fetchNotifications(),
                child: CommonText(text: 'Retry'),
              ),
            ],
          ),
        );
      }

      // Empty state
      if (notificationsController.notifications.isEmpty) {
        return Center(
          child: CommonText(text: 'No notifications yet'),
        );
      }

      // Notifications list
      return ListView(
        children: [
          // Follow Requests Section
          FollowRequestsTile(
            onTap: () => notificationsController.onFollowRequestsTap(),
          ),
          Divider(height: 1, color: Colors.grey[300]),

          // New Notifications Section
          _buildSectionHeader('New'),
          ...notificationsController.newNotifications
              .map((notification) => NotificationTile(
                    notification: notification,
                    onTap: () => controller.onNotificationTap(notification),
                  ))
              .toList(),

          // Today's Notifications Section
          _buildSectionHeader('Today'),
          ...notificationsController.todayNotifications
              .map((notification) => NotificationTile(
                    notification: notification,
                    onTap: () => controller.onNotificationTap(notification),
                  ))
              .toList(),
        ],
      );
    });
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: CommonText(
        text: text,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
