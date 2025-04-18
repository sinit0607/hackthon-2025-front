// lib/data/services/notification_service.dart
import '../response_model/notification_model.dart';

class NotificationService {
  // Simulate API call to fetch notifications
  Future<List<NotificationModel>> getNotifications() async {
    // Simulated delay to mimic network request
    await Future.delayed(Duration(seconds: 1));

    return [
      NotificationModel(
        id: '1',
        username: 'vivesh_jain',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'sent a follow request',
        timestamp: '101 others',
        type: NotificationType.followRequest,
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        username: 'riya_2510_',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'liked your post',
        timestamp: '1m',
        postImageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        type: NotificationType.like,
      ),
      NotificationModel(
        id: '3',
        username: 'a.new.dish',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'commented: 恐龙 😍',
        timestamp: '8m',
        postImageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        type: NotificationType.comment,
      ),
      NotificationModel(
        id: '4',
        username: 'monisha_shukla',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'commented: Beautiful pics ❤️',
        timestamp: '14m',
        postImageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        type: NotificationType.comment,
      ),
      NotificationModel(
        id: '5',
        username: 'neetukoshal',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'commented: Beautiful',
        timestamp: '29m',
        postImageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        type: NotificationType.comment,
      ),
      NotificationModel(
        id: '6',
        username: 'paimona',
        avatarUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        action: 'commented: Stunning you 😍',
        timestamp: '34m',
        postImageUrl: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        type: NotificationType.comment,
      ),
    ];
  }
}