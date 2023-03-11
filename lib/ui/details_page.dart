import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_event.dart';
import 'package:restaurants_apps/data/api/api.dart';
import 'package:restaurants_apps/utils/styles.dart';
import 'package:restaurants_apps/widget/load_data_error.dart';

import '../bloc/restaurant/bloc_state.dart';
import '../data/model/restaurants.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/details-page';

  final Restaurant restaurant;

  const DetailsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ListRestaurantBloc detailsRestaurantBloc =
      ListRestaurantBloc(api: Api(Client()));

  @override
  void initState() {
    detailsRestaurantBloc.add(DetailRestaurantFetch(id: widget.restaurant.id));
    super.initState();
  }

  Future<void> _onRefresh() async {
    detailsRestaurantBloc
        .add(DetailRestaurantRefresh(id: widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.restaurant.name.toString(),
        ),
      ),
      body: BlocBuilder(
        bloc: detailsRestaurantBloc,
        builder: (context, state) {
          if (state is OnFailure) {
            return LoadDataError(
              title: 'Problem Occured',
              subtitle: state.error ?? 'Something Went Wrong',
              bgColor: Colors.red,
              onTap: _onRefresh,
            );
          }
          if (state is DetailRestaurantLoaded) {
            if (state.dataList == null) {
              return const Center(
                child: Text('Tidak ada data ditemukan'),
              );
            }
            return _buildBody(context, restaurant: state.dataList.restaurant);
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: secondaryColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, {Restaurant? restaurant}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          const SizedBox(
            height: 10,
          ),
          _buildContent(),
          _buildDescription(),
          _buildMenus(context, restaurant),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/medium/';
    return Hero(
      tag: widget.restaurant.pictureId.toString(),
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              '$imageBaseUrl${widget.restaurant.pictureId}',
              loadingBuilder:
                  (context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const CircularProgressIndicator(
                  backgroundColor: secondaryColor,
                );
              },
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
            widget.restaurant.name.toString(),
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
                  widget.restaurant.city.toString(),
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
                  widget.restaurant.rating.toString(),
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
              widget.restaurant.description ?? "",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenus(BuildContext context, Restaurant? restaurant) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Drinks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          _buildDrinks(context, restaurant),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Foods',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          _buildFoods(context, restaurant)
        ],
      ),
    );
  }

  Widget _buildFoods(BuildContext context, Restaurant? restaurant) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant?.menus?.foods?.map((menus) {
              return Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                margin: const EdgeInsets.only(right: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Text(menus.name ?? ""),
              );
            }).toList() ??
            [],
      ),
    );
  }

  Widget _buildDrinks(BuildContext context, Restaurant? restaurant) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: restaurant?.menus?.drinks?.map((menus) {
              return Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                margin: const EdgeInsets.only(right: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade300,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Text(menus.name ?? ""),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
