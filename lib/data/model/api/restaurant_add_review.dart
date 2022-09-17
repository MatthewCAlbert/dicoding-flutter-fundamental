import 'dart:convert';

import 'package:restofulist/data/model/restaurant.dart';

class RestaurantAddReviewResponse {
  RestaurantAddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory RestaurantAddReviewResponse.fromRawJson(String str) =>
      RestaurantAddReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantAddReviewResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantAddReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class RestaurantAddReviewRequest {
  RestaurantAddReviewRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  String id;
  String name;
  String review;

  factory RestaurantAddReviewRequest.fromRawJson(String str) =>
      RestaurantAddReviewRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantAddReviewRequest.fromJson(Map<String, dynamic> json) =>
      RestaurantAddReviewRequest(
        id: json["id"],
        name: json["name"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
      };
}
