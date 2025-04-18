import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/components/app_color.dart';
import '../controllers/shorts_controller.dart';
import 'feed_item_widget.dart';

class ShortsView extends GetView<ShortVideoController> {
  ShortsView({Key? key}) : super(key: key);

  final ShortVideoController shortVideoController =
      Get.find<ShortVideoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (shortVideoController.isLoading.value &&
          shortVideoController.feedItems.isEmpty) {
        return _buildShimmerLoading();
      }

      if (shortVideoController.errorMessage.isNotEmpty &&
          shortVideoController.feedItems.isEmpty) {
        return _buildErrorView();
      }

      return Stack(
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: _buildPageView(),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildShimmerLoading() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView.builder(
          itemCount: 5, // Show 5 shimmer loading items
          itemBuilder: (_, __) => _buildShimmerItem(),
        ),
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header shimmer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Avatar shimmer
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Username shimmer
                  Container(
                    width: 100,
                    height: 14,
                    color: Colors.white,
                  ),
                  const Spacer(),
                  // More icon shimmer
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            // Video shimmer
            Container(
              width: double.infinity,
              height: 240, // Approximate video height
              color: Colors.white,
            ),

            // Action bar shimmer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++) ...[
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ],
                  const Spacer(),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            // Likes count shimmer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 80,
                height: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.errorMessage.value,
            style:  GoogleFonts.jost(color: Colors.white),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: shortVideoController.fetchFeedItems,
            child:  Text('Retry', style:  GoogleFonts.jost()),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Check if we're at the end of the list to load more
        if (shortVideoController.pageController.position.pixels ==
            shortVideoController.pageController.position.maxScrollExtent) {
          controller.loadMoreItems();
        }
        return false;
      },
      child: PageView.builder(
        controller: shortVideoController.pageController,
        scrollDirection: Axis.vertical,
        // Vertical scrolling
        itemCount: controller.feedItems.length +
            (controller.isLoading.value && controller.feedItems.isNotEmpty
                ? 1
                : 0),
        onPageChanged: (index) {
          // Update current playing index when page changes
          if (index < controller.feedItems.length) {
            controller.setCurrentlyPlaying(index);
          }
        },
        itemBuilder: (context, index) {
          // Show loading indicator at the end
          if (index == controller.feedItems.length) {
            return _buildBottomLoader();
          }

          // Return the feed item in a card with fixed layout
          return FeedItemWidget(
            key: ValueKey('feed-item-${controller.feedItems[index].id}'),
            feedItem: controller.feedItems[index],
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildBottomLoader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
