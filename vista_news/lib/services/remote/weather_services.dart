import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/models/weather_model.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/services/networking/chopper_services/weather_chopper/weather_chopper_services.dart';

class WeatherServices {
  static Future<Weather> getWeather() async {
    final weatherService =
        WeatherChopperService.create(ChopperClientInstance.weatherClient);

    try {
      final response = await weatherService.fetchWeather(
          WeatherApiConstants.weatherApiKey, 'London');

      if (response.isSuccessful && response.body != null) {
        return Weather.fromJson(response.body!);
      } else {
        throw Exception("Failed to load Weather: ${response.error}");
      }
    } catch (e) {
      throw Exception("Error fetching Weather: $e");
    }
  }
}
