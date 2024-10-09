import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/models/news.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/services/networking/chopper_services/news_chopper/news_chopper_services.dart';

class NewsServices {
  static Future<News> getTopNews() async {
    final newsService =
        NewsChopperServices.create(ChopperClientInstance.newsClient);

    try {
      final response = await newsService.fetchTopNews(
        NewsApiConstants.newsApiKey,
        'bbc-news,the-verge',
        'latest',
      );

      if (response.isSuccessful && response.body != null) {
        return response.body!;
      } else {
        throw Exception("Failed to load news: ${response.error}");
      }
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}
