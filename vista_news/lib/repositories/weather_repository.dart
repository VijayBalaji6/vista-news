import 'package:vista_news/models/weather/weather.dart';
import 'package:vista_news/services/remote/weather_services.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String userCity);
}

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<Weather> getWeather(String userCity) {
    return WeatherServices.getWeather(userCity: userCity);
  }
}
