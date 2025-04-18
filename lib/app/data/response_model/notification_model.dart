// lib/data/models/notification_model.dart
import 'package:get/get.dart';

enum NotificationType {
  followRequest,
  like,
  comment,
  mention,
  follow
}

class NotificationModel {
  final String id;
  final String username;
  final String avatarUrl;
  final String action;
  final String timestamp;
  final String? postImageUrl;
  final NotificationType type;
  final RxBool isRead;

  NotificationModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.action,
    required this.timestamp,
    required this.type,
    this.postImageUrl,
    bool isRead = false,
  }) : isRead = RxBool(isRead);

  // Convert to JSON for potential API/storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'avatarUrl': avatarUrl,
    'action': action,
    'timestamp': timestamp,
    'postImageUrl': postImageUrl,
    'type': type.toString(),
    'isRead': isRead.value,
  };

  // Create from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      action: json['action'],
      timestamp: json['timestamp'],
      postImageUrl: json['postImageUrl'],
      type: NotificationType.values.firstWhere(
              (e) => e.toString() == json['type']
      ),
      isRead: json['isRead'] ?? false,
    );
  }
}