import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:vista_news/models/location/location.dart';
import 'package:vista_news/services/remote/location_services.dart';

abstract class LocationRepository {
  Future<Location> fetchUserLocation(double latitude, double longitude);
  Future<Position> getCurrentPosition();
}

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Location> fetchUserLocation(double latitude, double longitude) async {
    return await LocationService.getUserLocation(
        latitude: latitude, longitude: longitude);
  }

  @override
  Future<Position> getCurrentPosition() async {
    return await LocationService.getCurrentPosition();
  }
}
