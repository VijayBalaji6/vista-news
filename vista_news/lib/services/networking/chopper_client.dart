import 'package:chopper/chopper.dart';
import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/services/networking/chopper_services/weather_chopper/weather_chopper_services.dart';

class ChopperClientInstance {
  static final ChopperClientInstance _newsClientInstance =
      ChopperClientInstance._internal();

  static final ChopperClientInstance _weatherClientInstance =
      ChopperClientInstance._internalWeather();

  ChopperClientInstance._internal();

  static ChopperClient? _newsClient;
  static ChopperClient? _weatherClient;

  static void initializeNewsClient() {
    _newsClient ??= ChopperClient(
      baseUrl: Uri.parse(NewsApiConstants.newsBaseURL),
      services: [],
      converter: const JsonConverter(),
    );
  }

  ChopperClientInstance._internalWeather();

  static void initializeWeatherClient() {
    _weatherClient ??= ChopperClient(
      baseUrl: Uri.parse(WeatherApiConstants.weatherBaseURL),
      services: [
        WeatherChopperService.create(),
      ],
      converter: const JsonConverter(),
    );
  }

  static ChopperClient get newsClient => _newsClient!;

  static ChopperClient get weatherClient => _weatherClient!;
}
