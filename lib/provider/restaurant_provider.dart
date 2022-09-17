import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/model/api/restaurant_detail.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';
import 'package:restofulist/data/model/api/restaurant_search.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetch();
  }

  late RestaurantListResponse _result;
  late ApiResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResponse get result => _result;

  ApiResultState get state => _state;

  Future<dynamic> _fetch() async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ApiResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ApiResultState.hasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetch('');
  }

  late RestaurantSearchResponse _result;
  late ApiResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearchResponse get result => _result;

  ApiResultState get state => _state;

  Future<dynamic> fetch(String query) async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ApiResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ApiResultState.hasData;
        notifyListeners();
        return _result = restaurant;
      }
    } catch (e) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetch(id);
  }

  late RestaurantDetailResponse _result;
  late ApiResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResponse get result => _result;

  ApiResultState get state => _state;

  Future<dynamic> _fetch(String id) async {
    try {
      _state = ApiResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantDetail(id);
      _state = ApiResultState.hasData;
      notifyListeners();
      return _result = restaurant;
    } catch (e) {
      _state = ApiResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
