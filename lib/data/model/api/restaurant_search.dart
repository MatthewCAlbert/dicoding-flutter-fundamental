import 'dart:convert';

import 'package:restofulist/data/model/api/restaurant_list.dart';

class RestaurantSearchResponse {
  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantShortVersion> restaurants;

  factory RestaurantSearchResponse.fromRawJson(String str) =>
      RestaurantSearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantShortVersion>.from(
            json["restaurants"].map((x) => RestaurantShortVersion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
