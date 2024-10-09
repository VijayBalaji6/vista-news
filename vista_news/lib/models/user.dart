import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  String userName;
  List<String> favNewsCategory;
  String? city;
  User({
    required this.userName,
    required this.favNewsCategory,
    this.city,
  });

  User copyWith({
    String? userName,
    List<String>? favNewsCategory,
    String? city,
  }) {
    return User(
      userName: userName ?? this.userName,
      favNewsCategory: favNewsCategory ?? this.favNewsCategory,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'favNewsCategory': favNewsCategory,
      'city': city,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
      favNewsCategory: List<String>.from((map['favNewsCategory'])),
      city: map['city'] != null ? map['city'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(userName: $userName, favNewsCategory: $favNewsCategory, city: $city)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        listEquals(other.favNewsCategory, favNewsCategory) &&
        other.city == city;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ favNewsCategory.hashCode ^ city.hashCode;
}
