import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/services/remote/news_services.dart';

abstract class NewsRepository {
  Future<News> fetchAllNews();
  Future<News> fetchFavNews(String favCategory);
}

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl();

  @override
  Future<News> fetchAllNews() async {
    return await NewsServices.getAllNews();
  }

  @override
  Future<News> fetchFavNews(String favCategory) async {
    return await NewsServices.getFavNews(favCategory: favCategory);
  }
}
