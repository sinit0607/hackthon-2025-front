import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:codesapp/app/data/components/app_color.dart';

import '../../../data/components/custom_text.dart';
import '../../../data/components/neopop_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlack,
      appBar: _buildAppBar(),
      body: Stack(
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: _buildProfileHeader(),
                  ),
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    title: _buildProfileStats(),
                    automaticallyImplyLeading: false,
                  ),
                ],
                body: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: _buildPostsGrid()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: CommonText(
        text: 'ezexplains',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.black,
      elevation: 0,
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildProfileAvatar(),
              const SizedBox(width: 16),
              _buildProfileStatsRow(),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildProfileInfo()),
              Expanded(
                child: PostButton(
                  onTap: () {
                    print("Post button tapped!");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
        ),
      ),
    );
  }

  Widget _buildProfileStatsRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn('413', 'Posts'),
          _buildStatColumn('902K', 'Followers'),
          _buildStatColumn('16', 'Following'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        CommonText(
          text: count,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        CommonText(
          text: label,
          color: Colors.grey,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: 'Neeraj Walia',
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        CommonText(text: 'Tech made Ez.', fontSize: 14),
        CommonText(
            text: 'Business - @itshimanshugaur',
            fontSize: 14,
            color: Colors.blue),
        CommonText(
            text: 'Work - work@ezsnippet.com',
            fontSize: 14,
            color: Colors.blue),
        CommonText(text: 'Coding ki dunia - @ezsnippet', fontSize: 14),
      ],
    );
  }

  Widget _buildProfileStats() {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatTab('POSTS', true),
              _buildStatTab('REELS', false),
              _buildStatTab('TAGGED', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatTab(String label, bool isSelected) {
    return Column(
      children: [
        CommonText(
          text: label,
          color: isSelected ? Colors.black : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        if (isSelected)
          Container(
            height: 2,
            width: 50,
            color: Colors.black,
          ),
      ],
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: controller.posts.length,
      itemBuilder: (context, index) {
        final post = controller.posts[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              post.image,
              fit: BoxFit.cover,
            ),
            if (post.title.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: CommonText(
                    text: post.title,
                    color: Colors.white,
                    fontSize: 10,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
