import 'package:flutter/cupertino.dart';
import 'package:restaurants_apps/data/helper/database_helper.dart';
import 'package:restaurants_apps/data/result_state.dart';

import '../../data/model/restaurants.dart';



class FavouriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavouriteProvider({required this.databaseHelper}) {
    _getRestaurant();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _favourite = [];

  List<Restaurant> get favourite => _favourite;

  void _getRestaurant() async {
    _favourite = await DatabaseHelper().getFavorite();
    if (_favourite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurant restaurant) async {
    try {
      await databaseHelper.insertRestaurant(restaurant);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final favouriteRestaurant = await databaseHelper.getRestaurantById(id);
    return favouriteRestaurant.isNotEmpty;
  }

  void removedFavourite(String id) async {
    try {
      await databaseHelper.deleteRestaurant(id);
      _getRestaurant();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
