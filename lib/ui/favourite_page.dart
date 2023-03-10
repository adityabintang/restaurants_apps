import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_apps/bloc/favourite/favourite_provider.dart';
import 'package:restaurants_apps/data/result_state.dart';
import 'package:restaurants_apps/widget/card_restaurant_widget.dart';

class BookmarksPage extends StatelessWidget {
  static const String bookmarksTitle = 'Favourite';

  const BookmarksPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<FavouriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favourite.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: provider.favourite[index],);
            },
          );
        } else {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(bookmarksTitle),
      ),
      body: _buildList(),
    );
  }
}
