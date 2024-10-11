class Location {
  double? latitude;
  double? longitude;
  String? localityLanguageRequested;
  String? continent;
  String? continentCode;
  String? countryName;
  String? countryCode;
  String? principalSubdivision;
  String? principalSubdivisionCode;
  String? city;
  String? locality;
  String? postcode;
  String? plusCode;
  LocalityInfo? localityInfo;

  Location(
      {this.latitude,
      this.longitude,
      this.localityLanguageRequested,
      this.continent,
      this.continentCode,
      this.countryName,
      this.countryCode,
      this.principalSubdivision,
      this.principalSubdivisionCode,
      this.city,
      this.locality,
      this.postcode,
      this.plusCode,
      this.localityInfo});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    localityLanguageRequested = json['localityLanguageRequested'];
    continent = json['continent'];
    continentCode = json['continentCode'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    principalSubdivision = json['principalSubdivision'];
    principalSubdivisionCode = json['principalSubdivisionCode'];
    city = json['city'];
    locality = json['locality'];
    postcode = json['postcode'];
    plusCode = json['plusCode'];
    localityInfo = json['localityInfo'] != null
        ? LocalityInfo.fromJson(json['localityInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['localityLanguageRequested'] = localityLanguageRequested;
    data['continent'] = continent;
    data['continentCode'] = continentCode;
    data['countryName'] = countryName;
    data['countryCode'] = countryCode;
    data['principalSubdivision'] = principalSubdivision;
    data['principalSubdivisionCode'] = principalSubdivisionCode;
    data['city'] = city;
    data['locality'] = locality;
    data['postcode'] = postcode;
    data['plusCode'] = plusCode;
    if (localityInfo != null) {
      data['localityInfo'] = localityInfo!.toJson();
    }
    return data;
  }
}

class LocalityInfo {
  List<Administrative>? administrative;
  List<Informative>? informative;

  LocalityInfo({this.administrative, this.informative});

  LocalityInfo.fromJson(Map<String, dynamic> json) {
    if (json['administrative'] != null) {
      administrative = <Administrative>[];
      json['administrative'].forEach((v) {
        administrative!.add(Administrative.fromJson(v));
      });
    }
    if (json['informative'] != null) {
      informative = <Informative>[];
      json['informative'].forEach((v) {
        informative!.add(Informative.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (administrative != null) {
      data['administrative'] = administrative!.map((v) => v.toJson()).toList();
    }
    if (informative != null) {
      data['informative'] = informative!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Administrative {
  String? name;
  String? description;
  String? isoName;
  int? order;
  int? adminLevel;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Administrative(
      {this.name,
      this.description,
      this.isoName,
      this.order,
      this.adminLevel,
      this.isoCode,
      this.wikidataId,
      this.geonameId});

  Administrative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    order = json['order'];
    adminLevel = json['adminLevel'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['isoName'] = isoName;
    data['order'] = order;
    data['adminLevel'] = adminLevel;
    data['isoCode'] = isoCode;
    data['wikidataId'] = wikidataId;
    data['geonameId'] = geonameId;
    return data;
  }
}

class Informative {
  String? name;
  String? description;
  String? isoName;
  int? order;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  Informative(
      {this.name,
      this.description,
      this.isoName,
      this.order,
      this.isoCode,
      this.wikidataId,
      this.geonameId});

  Informative.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    isoName = json['isoName'];
    order = json['order'];
    isoCode = json['isoCode'];
    wikidataId = json['wikidataId'];
    geonameId = json['geonameId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['isoName'] = isoName;
    data['order'] = order;
    data['isoCode'] = isoCode;
    data['wikidataId'] = wikidataId;
    data['geonameId'] = geonameId;
    return data;
  }
}
