import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:vista_news/common/constants/api_constants.dart';
import 'package:vista_news/models/location/location.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/services/networking/chopper_services/location_chopper/location_chopper_services.dart';
import 'package:vista_news/services/remote/api_core/api_error_handler.dart';
import 'package:vista_news/utils/util_services.dart';

class LocationService {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      UtilServices.showToast(
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        UtilServices.showToast(message: 'Location permissions are denied');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      UtilServices.showToast(
          message:
              'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    return true;
  }

  static Future<Position> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (hasPermission) {
        return await Geolocator.getCurrentPosition();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Location> getUserLocation({
    required double latitude,
    required double longitude,
  }) async {
    final locationService =
        LocationChopperServices.create(ChopperClientInstance.locationClient);

    try {
      final response = await locationService.getUserCity(
          latitude, longitude, 'en', LocationApiConstants.locationApiKey);

      if (response.isSuccessful && response.body != null) {
        return Location.fromJson(response.body!);
      } else {
        throw ApiErrorHandler.handleResponse(response);
      }
    } on SocketException {
      throw Exception("No Network");
    } catch (e) {
      throw Exception("Failed to load news: ");
    }
  }
}
