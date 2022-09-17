import 'dart:convert';

import 'package:restofulist/data/model/restaurant.dart';

class RestaurantDetailResponse {
  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory RestaurantDetailResponse.fromRawJson(String str) =>
      RestaurantDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
