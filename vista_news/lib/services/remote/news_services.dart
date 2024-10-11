import 'dart:io';

import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/services/networking/chopper_services/news_chopper/news_chopper_services.dart';
import 'package:vista_news/services/remote/api_core/api_error_handler.dart';

class NewsServices {
  static Future<News> getAllNews() async {
    final newsService =
        NewsChopperServices.create(ChopperClientInstance.newsClient);

    try {
      final response = await newsService.fetchTopNews(
        NewsApiConstants.newsApiKey,
        'bitcoin',
      );

      if (response.isSuccessful && response.body != null) {
        return News.fromMap(response.body!);
      } else {
        throw ApiErrorHandler.handleResponse(response);
      }
    } on SocketException {
      throw Exception("No Network");
    } catch (e) {
      throw Exception("Error fetching news");
    }
  }

  static Future<News> getFavNews({required String favCategory}) async {
    final newsService =
        NewsChopperServices.create(ChopperClientInstance.newsClient);

    try {
      final response = await newsService.fetchFavNews(
          NewsApiConstants.newsApiKey, favCategory);

      if (response.isSuccessful && response.body != null) {
        return News.fromMap(response.body!);
      } else {
        throw ApiErrorHandler.handleResponse(response);
      }
    } on SocketException {
      throw Exception("No Network");
    } catch (e) {
      throw Exception("Error fetching fav news");
    }
  }
}
