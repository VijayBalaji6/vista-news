// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_chopper_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherChopperService extends WeatherChopperService {
  _$WeatherChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherChopperService;

  @override
  Future<Response<Map<String, dynamic>>> fetchWeather(
    String apiKey,
    String city,
  ) {
    final Uri $url = Uri.parse('/current.json');
    final Map<String, dynamic> $params = <String, dynamic>{
      'key': apiKey,
      'q': city,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
