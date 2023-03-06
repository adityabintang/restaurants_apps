import 'package:restaurants_apps/data/model/restaurants.dart';

class RestaurantResult {
  RestaurantResult({
    required this.error,
    required this.message,
    required this.count,
    required this.founded,
    required this.restaurants,
    required this.restaurant,
  });

  final bool error;
  final String message;
  final int count;
  final int founded;
  final List<Restaurant> restaurants;
  final Restaurant? restaurant;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
          error: json['error'],
          message: json['message'] ?? "",
          count: json['count'] ?? 0,
          founded: json['founded'] ?? 0,
          restaurants: json['restaurants'] == null
              ? []
              : List<Restaurant>.from(
                  json['restaurants'].map(
                    (x) => Restaurant.fromJson(x),
                  ),
                ),
          restaurant: json['restaurant'] == null
              ? null
              : Restaurant.fromJson(json['restaurant']));
}
