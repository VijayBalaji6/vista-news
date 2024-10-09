import 'package:chopper/chopper.dart';
import 'package:vista_news/models/news.dart';

part 'news_chopper_services.chopper.dart';

@ChopperApi()
abstract class NewsChopperServices extends ChopperService {
  static NewsChopperServices create([ChopperClient? client]) =>
      _$NewsChopperServices(client);

  @Get(path: '/v2/top-headlines')
  Future<Response<News>> fetchTopNews(
    @Query('apiKey') String apiKey,
    @Query('sources') String sources,
    @Query('q') String? query,
  );
}
