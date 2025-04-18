import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/response_model/feed_item_model.dart';
import '../controllers/shorts_controller.dart';

class CommentsSheet extends StatelessWidget {
  final FeedItem feedItem;
  final TextEditingController _commentController = TextEditingController();
  final ShortVideoController _feedController = Get.find<ShortVideoController>();

  CommentsSheet({
    Key? key,
    required this.feedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Comments',
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            // Comments list
            Expanded(
              child: Obx(() => ListView.builder(
                    controller: scrollController,
                    itemCount: feedItem.comments.length,
                    itemBuilder: (context, index) {
                      final comment = feedItem.comments[index];
                      return Obx(() => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(comment.userAvatar),
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: GoogleFonts.jost(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: comment.username,
                                    style: GoogleFonts.jost(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(text: ' '),
                                  TextSpan(text: comment.text),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  comment.timeAgo,
                                  style: GoogleFonts.jost(
                                      color: Colors.grey[400], fontSize: 12),
                                ),
                                const SizedBox(width: 8),
                                if (comment.likes.value > 0)
                                  Text(
                                    '${comment.likes.value} likes',
                                    style: GoogleFonts.jost(
                                        color: Colors.grey[400], fontSize: 12),
                                  ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                comment.isLiked.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 16,
                                color: comment.isLiked.value
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () =>
                                  _feedController.toggleCommentLike(
                                feedItem.id,
                                comment.id,
                              ),
                            ),
                          ));
                    },
                  )),
            ),
            // Comment input
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                top: 8,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage:
                        NetworkImage('https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: GoogleFonts.jost(color: Colors.grey[400]),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _feedController.addComment(feedItem.id, value);
                          _commentController.clear();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_commentController.text.trim().isNotEmpty) {
                        _feedController.addComment(
                            feedItem.id, _commentController.text);
                        _commentController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Post',
                        style: GoogleFonts.jost(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
