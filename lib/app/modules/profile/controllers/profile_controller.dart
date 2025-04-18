// lib/modules/profile/controllers/profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostItem {
  final String image;
  final String title;
  final Color backgroundColor;

  PostItem({
    required this.image,
    required this.title,
    required this.backgroundColor,
  });
}

class ProfileController extends GetxController {
  final List<PostItem> posts = [
    PostItem(
      image:
          'https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: '2500 MOVIES in 1 SECOND',
      backgroundColor: Colors.black,
    ),
    PostItem(
      image:
          'https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: 'IPHONE PRICE RS 3LAKH /-',
      backgroundColor: Colors.black,
    ),
    PostItem(
      image:
          'https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: '150 NVIDIA GPU',
      backgroundColor: Colors.black,
    ),
    PostItem(
      image:
          'https://images.pexels.com/photos/777001/pexels-photo-777001.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: '',
      backgroundColor: Colors.black,
    ),
    PostItem(
      image:
          'https://images.pexels.com/photos/341523/pexels-photo-341523.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: '',
      backgroundColor: Colors.black,
    ),
    PostItem(
      image:
          'https://images.pexels.com/photos/577769/pexels-photo-577769.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: 'Activate Window',
      backgroundColor: Colors.black,
    ),
  ];

// Additional profile-related methods can be added here
}
