// Flutter imports:
import 'package:flutter/material.dart';
import 'package:restaurants_apps/data/model/restaurants.dart';
import 'package:restaurants_apps/widget/card_restaurant_widget.dart';
// Project imports:

class SearchResultWidget extends StatelessWidget {
  final List<Restaurant> items;
  final bool? visible;

  SearchResultWidget({Key? key, required this.items, bool? visible})
      : this.visible = visible ?? items.isEmpty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CardRestaurant(restaurant: items[index]);
      },
    );
  }
}
