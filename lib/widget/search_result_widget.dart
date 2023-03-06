// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurants_apps/data/model/restaurantresults.dart';
import 'package:restaurants_apps/data/model/restaurants.dart';
import 'package:http/http.dart' as http;
// Project imports:

class SearchResultWidget extends StatelessWidget {
  final List<Restaurant> items;
  final bool? visible;

  SearchResultWidget({Key? key, required this.items, bool? visible})
      : this.visible = visible ?? items.isEmpty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildRestaurantItem(context, items[index]);
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 0.2),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildBodyCard(restaurant)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyCard(Restaurant restaurant) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small/';
    return Row(
      children: [
        Hero(
          tag: restaurant.pictureId.toString(),
          child: Image.network(
            '$imageBaseUrl${restaurant.pictureId}',
            fit: BoxFit.cover,
            width: 100,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  restaurant.name ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: Text(
                      restaurant.city ?? "",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 3),
                    child: Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> getImage(String pictureID) async {
    final response = await http.get(Uri.parse(
        "https://restaurant-api.dicoding.dev/images/small/$pictureID"));
    return jsonDecode(response.body);
  }
}
