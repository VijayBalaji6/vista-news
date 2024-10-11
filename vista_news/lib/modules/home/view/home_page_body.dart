import 'package:flutter/material.dart';
import 'package:vista_news/modules/news/all_news/views/all_news_view.dart';
import 'package:vista_news/modules/news/fav_news/views/favorites_news_view.dart';
import 'package:vista_news/modules/news/saved_news/views/saved_news_view.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody({super.key, required this.currentPage});
  final int currentPage;

  final List<Widget> screens = [
    const AllNewsView(),
    const FavoritesNewsView(),
    const SavedNewsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return screens[currentPage];
  }
}
