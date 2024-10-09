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
  Future<Response<News>> fetchTopNews(
    String apiKey,
    String sources,
    String? query,
  ) {
    final Uri $url = Uri.parse('/v2/top-headlines');
    final Map<String, dynamic> $params = <String, dynamic>{
      'apiKey': apiKey,
      'sources': sources,
      'q': query,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<News, News>($request);
  }
}
