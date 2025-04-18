import 'package:get/get.dart';
import 'comment_model.dart';

class FeedItem {
  final String id;
  final String username;
  final String userAvatar;
  final String videoUrl;
  final String description;
  final RxInt likes;
  final String timeAgo;
  final RxList<Comment> comments;
  final RxBool isLiked;
  final RxBool isBookmarked;

  FeedItem({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.videoUrl,
    required this.description,
    required int likes,
    required this.timeAgo,
    required List<Comment> comments,
    bool isLiked = false,
    bool isBookmarked = false,
  }) :
        this.likes = likes.obs,
        this.comments = comments.obs,
        this.isLiked = isLiked.obs,
        this.isBookmarked = isBookmarked.obs;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userAvatar': userAvatar,
      'youtubeVideoId': videoUrl,
      'description': description,
      'likes': likes.value,
      'timeAgo': timeAgo,
      'comments': comments.map((c) => c.toJson()).toList(),
      'isLiked': isLiked.value,
      'isBookmarked': isBookmarked.value,
    };
  }

  static FeedItem fromJson(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'],
      username: json['username'],
      userAvatar: json['userAvatar'],
      videoUrl: json['youtubeVideoId'],
      description: json['description'],
      likes: json['likes'],
      timeAgo: json['timeAgo'],
      comments: (json['comments'] as List)
          .map((c) => Comment.fromJson(c))
          .toList(),
      isLiked: json['isLiked'] ?? false,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }
}