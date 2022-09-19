import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restofulist/data/model/api/restaurant_add_review.dart';
import 'package:restofulist/data/model/api/restaurant_detail.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/data/model/api/restaurant_search.dart';

enum ApiResultState { loading, noData, hasData, error, noInternet }

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final queryParams = Uri(queryParameters: {'q': query}).query;
    final response = await http.get(Uri.parse("$_baseUrl/search?$queryParams"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant detail');
    }
  }

  Future<RestaurantAddReviewResponse> addRestaurantReview(
      String id, String name, String review) async {
    final response = await http.post(Uri.parse("$_baseUrl/review"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': id,
          'name': name,
          'review': review,
        }));
    if (response.statusCode == 201) {
      return RestaurantAddReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add restaurant review');
    }
  }

  static String getPictureUrl(String pictureId) {
    return "$_baseUrl/images/medium/$pictureId";
  }
}
