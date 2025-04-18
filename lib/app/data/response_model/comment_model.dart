import 'package:get/get.dart';

class Comment {
  final String id;
  final String username;
  final String userAvatar;
  final String text;
  final String timeAgo;
  final RxInt likes;
  final RxBool isLiked;

  Comment({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.text,
    required this.timeAgo,
    int likes = 0,
    bool isLiked = false,
  }) :
        this.likes = likes.obs,
        this.isLiked = isLiked.obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userAvatar': userAvatar,
      'text': text,
      'timeAgo': timeAgo,
      'likes': likes.value,
      'isLiked': isLiked.value,
    };
  }

  static Comment fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      username: json['username'],
      userAvatar: json['userAvatar'],
      text: json['text'],
      timeAgo: json['timeAgo'],
      likes: json['likes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
    );
  }
}