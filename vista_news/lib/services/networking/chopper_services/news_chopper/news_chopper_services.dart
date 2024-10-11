import 'package:chopper/chopper.dart';
import 'package:vista_news/common/constants/api_constants.dart';

part 'news_chopper_services.chopper.dart';

@ChopperApi()
abstract class NewsChopperServices extends ChopperService {
  static NewsChopperServices create([ChopperClient? client]) =>
      _$NewsChopperServices(client);

  @Get(path: NewsApiConstants.allNewsUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  })
  Future<Response<Map<String, dynamic>>> fetchTopNews(
    @Query('apiKey') String apiKey,
    @Query('q') String query,
  );

  @Get(path: NewsApiConstants.favNewsUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  })
  Future<Response<Map<String, dynamic>>> fetchFavNews(
    @Query('apiKey') String apiKey,
    @Query('category') String category,
  );
}
