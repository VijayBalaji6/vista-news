// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_chopper_services.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NewsChopperServices extends NewsChopperServices {
  _$NewsChopperServices([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NewsChopperServices;

  @override
  Future<Response<Map<String, dynamic>>> fetchTopNews(
    String apiKey,
    String query,
  ) {
    final Uri $url = Uri.parse('/everything');
    final Map<String, dynamic> $params = <String, dynamic>{
      'apiKey': apiKey,
      'q': query,
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

  @override
  Future<Response<Map<String, dynamic>>> fetchFavNews(
    String apiKey,
    String category,
  ) {
    final Uri $url = Uri.parse('/top-headlines');
    final Map<String, dynamic> $params = <String, dynamic>{
      'apiKey': apiKey,
      'category': category,
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
