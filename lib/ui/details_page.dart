

// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:restaurants_apps/model/restaurant.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = '/details-page';

  final Restaurant restaurant;

  const DetailsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name.toString(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(
              height: 10,
            ),
            _buildContent(),
            _buildDescription(),
            _buildMenus(context),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: restaurant.pictureId.toString(),
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              restaurant.pictureId.toString(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: Colors.red,
                ),
                Text(
                  restaurant.city.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 20,
                  color: Colors.yellow,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
              restaurant.description,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Drinks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          _buildDrinks(context),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Foods',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          _buildFoods(context)
        ],
      ),
    );
  }

  Widget _buildFoods(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.foods.map((menus){
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            margin: const EdgeInsets.only(right: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Text(menus),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDrinks(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant.menus.drinks.map((menus){
          return Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            margin: const EdgeInsets.only(right: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Text(menus),
          );
        }).toList(),
      ),
    );
  }
}
