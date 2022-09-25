import 'package:flutter/foundation.dart';
import 'package:restofulist/data/api/api_service.dart';
import 'package:restofulist/data/db/database_helper.dart';
import 'package:restofulist/data/model/api/restaurant_list.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ApiResultState _state = ApiResultState.loading;
  ApiResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantShortVersion> _favorites = [];
  List<RestaurantShortVersion> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ApiResultState.hasData;
    } else {
      _state = ApiResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantShortVersion restaurant) async {
    try {
      print('haha');
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ApiResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ApiResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
