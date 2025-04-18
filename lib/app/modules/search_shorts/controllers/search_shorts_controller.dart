// search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response_model/search_item.dart';

class SearchShortsController extends GetxController {
  // Observable list for dummy data
  final RxList<SearchItem> allItems = <SearchItem>[
    SearchItem(
        name: 'Travel Photography',
        username: '@travelphotos',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Food Blogger',
        username: '@foodiehub',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Fitness Expert',
        username: '@fitnesslife',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Tech Reviews',
        username: '@techgeek',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Fashion Trends',
        username: '@fashionista',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Art Gallery',
        username: '@artlover',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Music Producer',
        username: '@beatmaker',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
    SearchItem(
        name: 'Book Reviews',
        username: '@bookworm',
        imageUrl:
            'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
  ].obs;

  // Observable list for filtered search results
  final RxList<SearchItem> filteredItems = <SearchItem>[].obs;

  // Observable for the search query
  final RxString searchQuery = ''.obs;

  // Observable to track if search has been performed
  final RxBool hasSearched = false.obs;

  // Text editing controller for the search field
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Add listener to the search controller
    searchTextController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchTextController.removeListener(_onSearchChanged);
    searchTextController.dispose();
    super.onClose();
  }

  // Method that gets called whenever search text changes
  void _onSearchChanged() {
    searchQuery.value = searchTextController.text;
    if (searchQuery.isEmpty) {
      filteredItems.clear();
      hasSearched.value = false;
    }
  }

  // Method to perform the search
  void search() {
    if (searchQuery.isEmpty) {
      filteredItems.clear();
      hasSearched.value = false;
      return;
    }

    hasSearched.value = true;

    // Filter items based on search query
    final query = searchQuery.value.toLowerCase();
    filteredItems.value = allItems
        .where((item) =>
            item.name.toLowerCase().contains(query) ||
            item.username.toLowerCase().contains(query))
        .toList();
  }

  // Method to clear the search
  void clearSearch() {
    searchTextController.clear();
    filteredItems.clear();
    hasSearched.value = false;
  }
}
