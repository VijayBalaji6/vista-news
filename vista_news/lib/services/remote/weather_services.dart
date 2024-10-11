import 'dart:io';

import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/models/weather/weather_model.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/services/networking/chopper_services/weather_chopper/weather_chopper_services.dart';
import 'package:vista_news/services/remote/api_core/api_error_handler.dart';

class WeatherServices {
  static Future<Weather> getWeather({required String userCity}) async {
    final weatherService =
        WeatherChopperService.create(ChopperClientInstance.weatherClient);

    try {
      final response = await weatherService.fetchWeather(
          WeatherApiConstants.weatherApiKey, userCity);

      if (response.isSuccessful && response.body != null) {
        return Weather.fromJson(response.body!);
      } else {
        throw ApiErrorHandler.handleResponse(response);
      }
    } on SocketException {
      throw Exception("No Network");
    } catch (e) {
      throw Exception("Error fetching Weather: ");
    }
  }
}
