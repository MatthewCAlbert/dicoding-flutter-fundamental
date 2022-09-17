import 'dart:convert';

class RestaurantListResponse {
  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantShortVersion> restaurants;

  factory RestaurantListResponse.fromRawJson(String str) =>
      RestaurantListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantShortVersion>.from(
            json["restaurants"].map((x) => RestaurantShortVersion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantShortVersion {
  RestaurantShortVersion({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantShortVersion.fromRawJson(String str) =>
      RestaurantShortVersion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantShortVersion.fromJson(Map<String, dynamic> json) =>
      RestaurantShortVersion(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
