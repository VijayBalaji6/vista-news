import 'package:chopper/chopper.dart';
import 'package:vista_news/common/constants/api_constants.dart';

part 'weather_chopper_services.chopper.dart';

@ChopperApi()
abstract class WeatherChopperService extends ChopperService {
  @Get(path: WeatherApiConstants.currentWeatherUrl)
  Future<Response<Map<String, dynamic>>> fetchWeather(
    @Query('key') String apiKey,
    @Query('q') String city,
  );

  static WeatherChopperService create([ChopperClient? client]) =>
      _$WeatherChopperService(client);
}
