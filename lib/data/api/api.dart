import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurants_apps/data/model/restaurantresults.dart';

class Api {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  final Client client;
  Api(this.client);

  Future<RestaurantResult> fetchList() async {
    final response = await client.get(
      Uri.parse("${_baseUrl}list"),
    );

    debugPrint('$response');
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw RestaurantResult.fromJson(json.decode(response.body)).message;
      // throw Exception('Failed to load List Restaurant');
    }
  }

  Future<RestaurantResult> fetchDetailsList(String id) async {
    final response = await client.get(
      Uri.parse("${_baseUrl}detail/$id"),
    );

    debugPrint('$response');
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<RestaurantResult> fetchSearch(String searchQuery) async {
    final response = await client.get(
      Uri.parse("${_baseUrl}search?q=$searchQuery"),
    );

    debugPrint('$response');
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }
}

final api = Api(Client());
