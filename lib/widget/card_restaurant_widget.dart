import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_apps/bloc/favourite/favourite_provider.dart';
import 'package:restaurants_apps/ui/details_page.dart';
import 'package:restaurants_apps/utils/navigator.dart';

import '../data/model/restaurants.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small/';
    return Consumer<FavouriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavourite(restaurant.id.toString()),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ListTile(
                    trailing: isBookmarked
                        ? IconButton(
                            icon: const Icon(Icons.favorite),
                            color: Colors.red,
                            onPressed: () => provider.removedFavourite(restaurant.id.toString()),
                          )
                        : IconButton(
                            icon: const Icon(Icons.favorite_outline),
                            color: Colors.red,
                            onPressed: () => provider.addRestaurant(restaurant),
                          ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    leading: restaurant.pictureId != null
                        ? Hero(
                            tag: restaurant.pictureId.toString(),
                            child: Image.network(
                              '$imageBaseUrl${restaurant.pictureId}',
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          )
                        : const Center(
                            child: Text('No Image Available'),
                          ),
                    title: Text(
                      restaurant.name ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Text(
                              restaurant.city ?? "",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigation.intentWithData(DetailsPage.routeName, restaurant);
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
