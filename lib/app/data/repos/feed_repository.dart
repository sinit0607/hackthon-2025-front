import '../response_model/comment_model.dart';
import '../response_model/feed_item_model.dart';

class FeedRepository {
  // Simulates API calls and data fetching
  Future<List<FeedItem>> getFeedItems() async {
    // In a real app, this would call an API endpoint
    await Future.delayed(const Duration(seconds: 1));

    return [
      FeedItem(
        id: '1',
        username: 'travelvlogger',
        userAvatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        videoUrl: 'https://the-tripcoin.com/v1.mp4',
        // Sample YouTube video
        description: 'This classic never gets old! #throwback #music',
        likes: 5842,
        timeAgo: '2d',
        comments: [
          Comment(
            id: '1_1',
            username: 'user2',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'Love this song!',
            timeAgo: '1d',
          ),
          Comment(
            id: '1_2',
            username: 'user3',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'Got rickrolled again 😂',
            timeAgo: '12h',
          ),
        ],
      ),
      FeedItem(
        id: '2',
        username: 'tedtalks',
        userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
        videoUrl:
            'https://the-tripcoin.com/v2.mp4',
        // Sample YouTube video
        description:
            'Inspiring talk on how technology is changing our lives #education #technology',
        likes: 7865,
        timeAgo: '3d',
        comments: [
          Comment(
            id: '3_1',
            username: 'techguy',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'This changed my perspective completely',
            timeAgo: '2d',
          ),
          Comment(
            id: '3_2',
            username: 'futuredev',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'Going to implement some of these ideas in my project',
            timeAgo: '1d',
          ),
        ],
      ),
      FeedItem(
        id: '3',
        username: 'tedtalks',
        userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
        videoUrl:
            'https://the-tripcoin.com/v3.mp4',
        // Sample YouTube video
        description:
            'Inspiring talk on how technology is changing our lives #education #technology',
        likes: 7865,
        timeAgo: '3d',
        comments: [
          Comment(
            id: '3_1',
            username: 'techguy',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'This changed my perspective completely',
            timeAgo: '2d',
          ),
          Comment(
            id: '3_2',
            username: 'futuredev',
            userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
            text: 'Going to implement some of these ideas in my project',
            timeAgo: '1d',
          ),
        ],
      ),
    ];
  }

  // Add a mock API call to add a comment
  Future<Comment> addComment(String feedItemId, String commentText) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Create a new comment
    return Comment(
      id: '${feedItemId}_${DateTime.now().millisecondsSinceEpoch}',
      username: 'currentUser',
      userAvatar: 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&w=1200',
      text: commentText,
      timeAgo: 'Just now',
    );
  }

  // Add a mock API call to toggle like on a feed item
  Future<void> toggleLike(String feedItemId, bool newLikeState) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real app, this would update the server
    return;
  }

  // Add a mock API call to toggle bookmark on a feed item
  Future<void> toggleBookmark(String feedItemId, bool newBookmarkState) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real app, this would update the server
    return;
  }
}
