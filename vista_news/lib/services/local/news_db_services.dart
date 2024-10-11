import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/utils/util_services.dart';

class NewsDbService {
  static final NewsDbService _instance = NewsDbService._internal();
  late Isar _isar;

  NewsDbService._internal();

  factory NewsDbService() {
    return _instance;
  }

  Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          ArticlesSchema,
        ],
        directory: dir.path,
      );
    }
  }

  Future<void> storeNews(Articles article) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.articles.put(article);
      });
      UtilServices.showToast(message: "News saved");
    } catch (e) {
      UtilServices.showToast(message: "Failed to save news");
    }
  }

  Future<List<Articles>> getAllSavedNews() async {
    return await _isar.articles.where().findAll();
  }

  Future<void> deleteSavedNews(int id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.articles.delete(id);
      });
      UtilServices.showToast(message: "News Deleted");
    } catch (e) {
      UtilServices.showToast(message: "Failed to delete news");
    }
  }

  Future<void> clearDatabase() async {
    try {
      await _isar.writeTxn(() async {
        await _isar.clear();
      });
      UtilServices.showToast(message: "User data deleted");
    } catch (e) {
      UtilServices.showToast(message: "Failed to delete user data");
    }
  }

  Future<void> close() async {
    await _isar.close();
  }
}
