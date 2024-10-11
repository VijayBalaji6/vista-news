import 'package:chopper/chopper.dart';
import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/services/networking/chopper_services/news_chopper/news_chopper_services.dart';
import 'package:vista_news/services/networking/chopper_services/weather_chopper/weather_chopper_services.dart';

class ChopperClientInstance {
  static final ChopperClientInstance _newsClientInstance =
      ChopperClientInstance._internalNews();

  static final ChopperClientInstance _weatherClientInstance =
      ChopperClientInstance._internalWeather();

  static final ChopperClientInstance _locationClientInstance =
      ChopperClientInstance._internalLocation();

  ChopperClientInstance._internalNews();
  ChopperClientInstance._internalWeather();
  ChopperClientInstance._internalLocation();

  static ChopperClient? _newsClient;
  static ChopperClient? _weatherClient;
  static ChopperClient? _locationClient;

  static void initializeNewsClient() {
    _newsClient ??= ChopperClient(
      baseUrl: Uri.parse(NewsApiConstants.newsBaseURL),
      services: [
        NewsChopperServices.create(),
      ],
      converter: const JsonConverter(),
    );
  }

  static void initializeWeatherClient() {
    _weatherClient ??= ChopperClient(
      baseUrl: Uri.parse(WeatherApiConstants.weatherBaseURL),
      services: [
        WeatherChopperService.create(),
      ],
      converter: const JsonConverter(),
    );
  }

  static void initializeLocationClient() {
    _locationClient ??= ChopperClient(
      baseUrl: Uri.parse(LocationApiConstants.locationBaseURL),
      services: [
        WeatherChopperService.create(),
      ],
      converter: const JsonConverter(),
    );
  }

  static ChopperClient get newsClient => _newsClient!;

  static ChopperClient get weatherClient => _weatherClient!;

  static ChopperClient get locationClient => _locationClient!;
}
