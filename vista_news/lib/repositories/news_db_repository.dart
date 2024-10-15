import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/services/local/news_db_services.dart';

abstract class NewsDbRepository {
  Future<void> saveNews(Articles article);
  Future<List<Articles>> getAllSavedNews();
  Future<void> deleteNewsById(int id);
  Future<void> clearNewsDatabase();
}

class NewsDBRepositoryImpl implements NewsDbRepository {
  final NewsDbService _newsDbService = NewsDbService();

  NewsDBRepositoryImpl();

  @override
  Future<void> saveNews(Articles article) async {
    await _newsDbService.storeNews(article);
  }

  @override
  Future<List<Articles>> getAllSavedNews() async {
    return await _newsDbService.getAllSavedNews();
  }

  @override
  Future<void> deleteNewsById(int id) async {
    await _newsDbService.deleteSavedNews(id);
  }

  @override
  Future<void> clearNewsDatabase() async {
    await _newsDbService.clearDatabase();
  }
}
