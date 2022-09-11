import 'dart:convert';

class Restaurants {
  Restaurants({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory Restaurants.fromRawJson(String str) =>
      Restaurants.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<RestaurantMenuItem> foods;
  List<RestaurantMenuItem> drinks;

  factory Menus.fromRawJson(String str) => Menus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<RestaurantMenuItem>.from(
            json["foods"].map((x) => RestaurantMenuItem.fromJson(x))),
        drinks: List<RestaurantMenuItem>.from(
            json["drinks"].map((x) => RestaurantMenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class RestaurantMenuItem {
  RestaurantMenuItem({
    required this.name,
  });

  String name;

  factory RestaurantMenuItem.fromRawJson(String str) =>
      RestaurantMenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantMenuItem.fromJson(Map<String, dynamic> json) =>
      RestaurantMenuItem(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final parsed = jsonDecode(json);
  return Restaurants.fromJson(parsed).restaurants.toList();
}
