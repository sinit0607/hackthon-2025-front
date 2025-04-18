// clean_search_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/custom_text.dart';

import '../../../data/components/config.dart';
import '../../../data/components/custome_textfeild.dart';
import '../../../data/components/get_size.dart';
import '../../shorts/controllers/shorts_controller.dart';
import '../../shorts/views/feed_item_widget.dart';
import '../controllers/search_shorts_controller.dart';

class SearchShortsView extends StatelessWidget {
  SearchShortsView({Key? key}) : super(key: key);

  // Get the controller
  final SearchShortsController searchShortsController =
      Get.put(SearchShortsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlack,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 40,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CommonTextField(
                        suffix:
                            Obx(() => searchShortsController.searchQuery.isNotEmpty
                                ? IconButton(
                                    icon:
                                        const Icon(Icons.clear, color: Colors.grey),
                                    onPressed: searchShortsController.clearSearch,
                                  )
                                : const SizedBox.shrink()),
                        maxLength: 10,
                        focusNode: FocusNode(),
                        prefixIcon: SizedBox(
                          width: W.w5(context),
                          height: H.h5(context),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                              color: AppColors.appWhite,
                            ),
                          ),
                        ),
                        hintText: "search",
                        hintStyle: buildCommonStyle(),
                        controller: searchShortsController.searchTextController,
                        suffixVisibility: true,
                        onSaved: (_) => searchShortsController.search(),
                        onChanged: (_) => searchShortsController.search(),
                      ),
                    ),
                    // Search Bar

                    // Search Results (only shown after search)
                    Expanded(
                      child: Obx(() {
                        // If the user has searched and there are no results
                        if (searchShortsController.hasSearched.value &&
                            searchShortsController.filteredItems.isEmpty) {
                          return const Center(
                            child: Text(
                              'No results found',
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        // If there are search results
                        if (searchShortsController.filteredItems.isNotEmpty) {
                          return ListView.builder(
                            itemCount: searchShortsController.filteredItems.length,
                            itemBuilder: (context, index) {
                              final item =
                                  searchShortsController.filteredItems[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(item.imageUrl),
                                ),
                                title: CommonText(
                                  text: item.name,
                                  textAlign: TextAlign.start,
                                ),
                                subtitle: CommonText(
                                  text: item.username,
                                  textAlign: TextAlign.start,
                                ),
                                onTap: () {},
                              );
                            },
                          );
                        }

                        // Empty space when no search has been performed
                        return const SizedBox();
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _buildPageView(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildPageView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Check if we're at the end of the list to load more
        if (Get.find<ShortVideoController>().pageController.position.pixels ==
            Get.find<ShortVideoController>()
                .pageController
                .position
                .maxScrollExtent) {
          Get.find<ShortVideoController>().loadMoreItems();
        }
        return false;
      },
      child: PageView.builder(
        controller: Get.find<ShortVideoController>().pageController,
        scrollDirection: Axis.vertical,
        // Vertical scrolling
        itemCount: Get.find<ShortVideoController>().feedItems.length +
            (Get.find<ShortVideoController>().isLoading.value && Get.find<ShortVideoController>().feedItems.isNotEmpty
                ? 1
                : 0),
        onPageChanged: (index) {
          // Update current playing index when page changes
          if (index < Get.find<ShortVideoController>().feedItems.length) {
            Get.find<ShortVideoController>().setCurrentlyPlaying(index);
          }
        },
        itemBuilder: (context, index) {
          // Show loading indicator at the end
          if (index == Get.find<ShortVideoController>().feedItems.length) {
            return _buildBottomLoader();
          }

          // Return the feed item in a card with fixed layout
          return FeedItemWidget(
            key: ValueKey('feed-item-${Get.find<ShortVideoController>().feedItems[index].id}'),
            feedItem: Get.find<ShortVideoController>().feedItems[index],
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
