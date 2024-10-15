import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final Location? location;
  final Current? current;

  const Weather({this.location, this.current});

  Weather.fromJson(Map<String, dynamic> json)
      : location = json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        current =
            json['current'] != null ? Current.fromJson(json['current']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [location, current];
}

class Location extends Equatable {
  final String? name;
  final String? region;
  final String? country;
  final num? lat;
  final num? lon;
  final String? tzId;
  final num? localtimeEpoch;
  final String? localtime;

  const Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        region = json['region'],
        country = json['country'],
        lat = json['lat'],
        lon = json['lon'],
        tzId = json['tz_id'],
        localtimeEpoch = json['localtime_epoch'],
        localtime = json['localtime'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['tz_id'] = tzId;
    data['localtime_epoch'] = localtimeEpoch;
    data['localtime'] = localtime;
    return data;
  }

  @override
  List<Object?> get props => [
        name,
        region,
        country,
        lat,
        lon,
        tzId,
        localtimeEpoch,
        localtime,
      ];
}

class Current extends Equatable {
  final num? lastUpdatedEpoch;
  final String? lastUpdated;
  final num? tempC;
  final num? tempF;
  final num? isDay;
  final Condition? condition;
  final num? windMph;
  final num? windKph;
  final num? windDegree;
  final String? windDir;
  final num? pressureMb;
  final num? pressureIn;
  final num? precipMm;
  final num? precipIn;
  final num? humidity;
  final num? cloud;
  final num? feelslikeC;
  final num? feelslikeF;
  final num? visKm;
  final num? visMiles;
  final num? uv;
  final num? gustMph;
  final num? gustKph;
  final AirQuality? airQuality;

  const Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
  });

  Current.fromJson(Map<String, dynamic> json)
      : lastUpdatedEpoch = json['last_updated_epoch'],
        lastUpdated = json['last_updated'],
        tempC = json['temp_c'],
        tempF = json['temp_f'],
        isDay = json['is_day'],
        condition = json['condition'] != null
            ? Condition.fromJson(json['condition'])
            : null,
        windMph = json['wind_mph'],
        windKph = json['wind_kph'],
        windDegree = json['wind_degree'],
        windDir = json['wind_dir'],
        pressureMb = json['pressure_mb'],
        pressureIn = json['pressure_in'],
        precipMm = json['precip_mm'],
        precipIn = json['precip_in'],
        humidity = json['humidity'],
        cloud = json['cloud'],
        feelslikeC = json['feelslike_c'],
        feelslikeF = json['feelslike_f'],
        visKm = json['vis_km'],
        visMiles = json['vis_miles'],
        uv = json['uv'],
        gustMph = json['gust_mph'],
        gustKph = json['gust_kph'],
        airQuality = json['air_quality'] != null
            ? AirQuality.fromJson(json['air_quality'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_updated_epoch'] = lastUpdatedEpoch;
    data['last_updated'] = lastUpdated;
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;
    data['pressure_mb'] = pressureMb;
    data['pressure_in'] = pressureIn;
    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;
    data['uv'] = uv;
    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;
    if (airQuality != null) {
      data['air_quality'] = airQuality!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        lastUpdatedEpoch,
        lastUpdated,
        tempC,
        tempF,
        isDay,
        condition,
        windMph,
        windKph,
        windDegree,
        windDir,
        pressureMb,
        pressureIn,
        precipMm,
        precipIn,
        humidity,
        cloud,
        feelslikeC,
        feelslikeF,
        visKm,
        visMiles,
        uv,
        gustMph,
        gustKph,
        airQuality,
      ];
}

class Condition extends Equatable {
  final String? text;
  final String? icon;
  final num? code;

  const Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        icon = json['icon'],
        code = json['code'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }

  @override
  List<Object?> get props => [text, icon, code];
}

class AirQuality extends Equatable {
  final num? co;
  final num? no2;
  final num? o3;
  final num? so2;
  final num? pm25;
  final num? pm10;
  final num? usEpaIndex;
  final num? gbDefraIndex;

  const AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usEpaIndex,
    this.gbDefraIndex,
  });

  AirQuality.fromJson(Map<String, dynamic> json)
      : co = json['co'],
        no2 = json['no2'],
        o3 = json['o3'],
        so2 = json['so2'],
        pm25 = json['pm2_5'],
        pm10 = json['pm10'],
        usEpaIndex = json['us-epa-index'],
        gbDefraIndex = json['gb-defra-index'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['co'] = co;
    data['no2'] = no2;
    data['o3'] = o3;
    data['so2'] = so2;
    data['pm2_5'] = pm25;
    data['pm10'] = pm10;
    data['us-epa-index'] = usEpaIndex;
    data['gb-defra-index'] = gbDefraIndex;
    return data;
  }

  @override
  List<Object?> get props =>
      [co, no2, o3, so2, pm25, pm10, usEpaIndex, gbDefraIndex];
}
