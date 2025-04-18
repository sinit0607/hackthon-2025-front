import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:codesapp/app/data/components/app_color.dart';
import 'package:codesapp/app/data/components/app_icons_path.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../data/components/custom_text.dart';
import '../../../data/response_model/feed_item_model.dart';
import '../controllers/shorts_controller.dart';
import 'comment_bottom_sheet_config.dart';

class FeedItemWidget extends StatefulWidget {
  final FeedItem feedItem;
  final int index;

  const FeedItemWidget({
    super.key,
    required this.feedItem,
    required this.index,
  });

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late VideoPlayerController _controller;
  final ShortVideoController _feedController = Get.find<ShortVideoController>();
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    final videoUrl = widget.feedItem.videoUrl;

    _controller = VideoPlayerController.network(videoUrl);

    try {
      await _controller.initialize();
      _controller.setLooping(true);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }

      // Add listener to update UI when player state changes
      _controller.addListener(() {
        final isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying && mounted) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.fullscreen_exit,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _isFullScreen = false;
                        });
                      },
                    ),
                  ),
                  // Video Controls in fullscreen
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildVideoControls(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildVideoControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.black54,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),

          // Video Player
          _buildVideoPlayer(),

          // Action Bar
          _buildActionBar(),

          // Likes Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() => Text(
                  '${widget.feedItem.likes.value} likes',
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.jost(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: widget.feedItem.username,
                    style: GoogleFonts.jost(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: widget.feedItem.description),
                ],
              ),
            ),
          ),

          // View all comments
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() => widget.feedItem.comments.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      // Show comments in a modal sheet
                      _showCommentsBottomSheet(context);
                    },
                    child: Text(
                      'View all ${widget.feedItem.comments.length} comments',
                      style: GoogleFonts.jost(color: Colors.grey[400]),
                    ),
                  )
                : const SizedBox.shrink()),
          ),

          // Time ago
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              widget.feedItem.timeAgo,
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
          ),

          // Comment input
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(widget.feedItem.userAvatar),
          ),
          const SizedBox(width: 8),
          Text(
            widget.feedItem.username,
            style: GoogleFonts.jost(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 19),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return VisibilityDetector(
      key: Key('video-${widget.feedItem.id}'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.7) {
          // Play video when more than 70% visible
          _feedController.setCurrentlyPlaying(widget.index);
          if (_isInitialized && !_isPlaying) {
            _controller.play();
          }
        } else {
          // Pause video when less than 70% visible
          if (_isInitialized && _isPlaying) {
            _controller.pause();
          }
        }
      },
      child: AspectRatio(
        aspectRatio: _isInitialized ? _controller.value.aspectRatio : 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video Player or Shimmer loading effect
            _isInitialized
                ? VideoPlayer(_controller)
                : Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),

            // Loading indicator on top of shimmer
            if (!_isInitialized)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            // Play/Pause Overlay with controls
            if (_isInitialized)
              GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                },
                child: Stack(
                  children: [
                    // Transparent container for tap
                    Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    // Play/Pause icon in center
                    Center(
                      child: AnimatedOpacity(
                        opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Fullscreen button
                    Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: _toggleFullScreen,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            Icons.fullscreen,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Video Progress Indicator
            if (_isInitialized)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                    backgroundColor: Colors.black54,
                  ),
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Obx(
            () => IconButton(
              icon: !widget.feedItem.isLiked.value
                  ? Image.asset(
                      AppIcons.heartIcon,
                      scale: 20,
                      color: AppColors.appWhite,
                    )
                  : Image.asset(
                      AppIcons.heartRedIcon,
                      scale: 20,
                    ),
              onPressed: () => _feedController.toggleLike(widget.feedItem.id),
            ),
          ),
          IconButton(
            icon: Image.asset(
              AppIcons.commentIcon,
              scale: 22,
              color: AppColors.appWhite,
            ),
            onPressed: () {
              // Focus on comment field
              FocusScope.of(context).requestFocus(FocusNode());
              _showCommentsBottomSheet(context);
            },
          ),
          IconButton(
            icon: Image.asset(
              AppIcons.sendIcon,
              scale: 22,
              color: AppColors.appWhite,
            ),
            onPressed: () {},
          ),
          const Spacer(),
          Obx(() => IconButton(
                icon: Icon(
                  widget.feedItem.isBookmarked.value
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () =>
                    _feedController.toggleBookmark(widget.feedItem.id),
              )),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _commentController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: GoogleFonts.jost(color: Colors.grey[400]),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  _feedController.addComment(widget.feedItem.id, value);
                  _commentController.clear();
                }
              },
            ),
          ),
          TextButton(
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                _feedController.addComment(
                    widget.feedItem.id, _commentController.text);
                _commentController.clear();
              }
            },
            child: const CommonText(
              text: "post",
              maxLines: 2,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return CommentsSheet(feedItem: widget.feedItem);
      },
    );
  }
}
