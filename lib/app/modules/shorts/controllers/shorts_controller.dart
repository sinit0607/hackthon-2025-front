import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repos/feed_repository.dart';
import '../../../data/response_model/feed_item_model.dart';


class ShortVideoController extends GetxController {
  final FeedRepository _repository = FeedRepository();
  final PageController pageController = PageController();
  final RxList<FeedItem> feedItems = <FeedItem>[].obs;
  final RxInt currentlyPlayingIndex = (-1).obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasMoreData = true.obs;

  // For lazy loading
  final int _itemsPerPage = 5;
  int _currentPage = 0;

  @override
  void onInit() {
    super.onInit();
    fetchFeedItems();
  }

  Future<void> fetchFeedItems({bool refresh = false}) async {
    try {
      if (refresh) {
        isLoading.value = true;
        _currentPage = 0;
        hasMoreData.value = true;
        feedItems.clear();
      } else if (isLoading.value) {
        // Avoid multiple simultaneous fetches
        return;
      } else {
        isLoading.value = true;
      }

      errorMessage.value = '';

      final items = await _repository.getFeedItems();

      // In a real app with pagination, you'd use _currentPage and _itemsPerPage
      // Here we're just simulating it with the mock data
      if (items.isEmpty) {
        hasMoreData.value = false;
      } else {
        feedItems.addAll(items);
        _currentPage++;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load feed: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreItems() {
    if (!isLoading.value && hasMoreData.value) {
      fetchFeedItems();
    }
  }

  Future<void> toggleLike(String itemId) async {
    final index = feedItems.indexWhere((item) => item.id == itemId);
    if (index == -1) return;

    final item = feedItems[index];
    final newLikeState = !item.isLiked.value;

    // Optimistically update UI
    item.isLiked.value = newLikeState;

    // Update like count
    if (newLikeState) {
      item.likes.value++;
    } else {
      item.likes.value--;
    }

    try {
      // Call repository (which would update server in a real app)
      await _repository.toggleLike(itemId, newLikeState);
    } catch (e) {
      // Revert on error
      item.isLiked.value = !newLikeState;
      if (item.isLiked.value) {
        item.likes.value++;
      } else {
        item.likes.value--;
      }

      Get.snackbar(
        'Error',
        'Failed to update like status',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> toggleBookmark(String itemId) async {
    final index = feedItems.indexWhere((item) => item.id == itemId);
    if (index == -1) return;

    final item = feedItems[index];
    final newBookmarkState = !item.isBookmarked.value;

    // Optimistically update UI
    item.isBookmarked.value = newBookmarkState;

    try {
      // Call repository (which would update server in a real app)
      await _repository.toggleBookmark(itemId, newBookmarkState);
    } catch (e) {
      // Revert on error
      item.isBookmarked.value = !newBookmarkState;
      Get.snackbar(
        'Error',
        'Failed to update bookmark status',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  void setCurrentlyPlaying(int index) {
    if (currentlyPlayingIndex.value != index && currentlyPlayingIndex.value != -1) {
      // Previous video pausing is handled by the widget with VisibilityDetector
    }
    currentlyPlayingIndex.value = index;
  }

  Future<void> addComment(String itemId, String commentText) async {
    if (commentText.trim().isEmpty) return;

    final index = feedItems.indexWhere((item) => item.id == itemId);
    if (index == -1) return;

    try {
      final newComment = await _repository.addComment(itemId, commentText);

      // Update local state
      feedItems[index].comments.add(newComment);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add comment',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  void toggleCommentLike(String itemId, String commentId) {
    final itemIndex = feedItems.indexWhere((item) => item.id == itemId);
    if (itemIndex == -1) return;

    final commentIndex = feedItems[itemIndex].comments.indexWhere((comment) => comment.id == commentId);
    if (commentIndex == -1) return;

    final comment = feedItems[itemIndex].comments[commentIndex];

    // Toggle isLiked state
    final newLikeState = !comment.isLiked.value;
    comment.isLiked.value = newLikeState;

    // Update like count
    comment.likes.value = newLikeState
        ? comment.likes.value + 1
        : comment.likes.value - 1;
  }

}