// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_chopper_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$LocationChopperServices extends LocationChopperServices {
  _$LocationChopperServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = LocationChopperServices;

  @override
  Future<Response<Map<String, dynamic>>> getUserCity(
    double latitude,
    double longitude,
    String language,
    String apiKey,
  ) {
    final Uri $url = Uri.parse('/data/reverse-geocode');
    final Map<String, dynamic> $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'localityLanguage': language,
      'key': apiKey,
    };
    final Map<String, String> $headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
