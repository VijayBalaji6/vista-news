import 'package:chopper/chopper.dart';
import 'package:vista_news/common/constants/api_constants.dart';

part 'location_chopper_services.chopper.dart';

@ChopperApi()
abstract class LocationChopperServices extends ChopperService {
  static LocationChopperServices create([ChopperClient? client]) =>
      _$LocationChopperServices(client);

  @Get(path: LocationApiConstants.geoLocUrl, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  })
  Future<Response<Map<String, dynamic>>> getUserCity(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('localityLanguage') String language,
    @Query('key') String apiKey,
  );
}
