import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:restaurants_apps/data/model/restaurantresults.dart';
//
// class SearchApi {
//   final Map<String, RestaurantResult> cache;
//
//   SearchApi({
//     Map<String, RestaurantResult>? cache,
//   }) : this.cache = cache ?? <String, RestaurantResult>{};
//
//   /// Search Github for repositories using the given term
//   Future<RestaurantResult> search(String term) async {
//     if (cache.containsKey(term)) {
//       return cache[term]!;
//     } else {
//       final result = await _fetchResults(term);
//
//       cache[term] = result;
//
//       return result;
//     }
//   }
//
//   Future<RestaurantResult> _fetchResults(String term) async {
//     final response = await http.get(
//         Uri.parse("https://restaurant-api.dicoding.dev/search?q=$term")
//     );
//     final results = json.decode(response.body);
//
//     return RestaurantResult.fromJson(results);
//   }
// }
