import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurants_apps/data/model/restaurantresults.dart';

class Api {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantResult> fetchList([http.Client? client]) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}list"),
    );

    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw RestaurantResult.fromJson(json.decode(response.body)).message;
      // throw Exception('Failed to load List Restaurant');
    }
  }

  Future<RestaurantResult> fetchDetailsList(String id) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}detail/$id"),
    );

    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<RestaurantResult> fetchSearch(String searchQuery) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}search?q=$searchQuery"),
    );

    print(response);
    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }
}

final api = Api();
