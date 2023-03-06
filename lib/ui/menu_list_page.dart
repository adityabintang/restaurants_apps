import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_event.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_state.dart';
import 'package:restaurants_apps/data/api/api.dart';
import 'package:restaurants_apps/data/model/restaurants.dart';
import 'package:restaurants_apps/ui/details_page.dart';
import 'package:http/http.dart' as http;
import 'package:restaurants_apps/utils/styles.dart';
import 'package:restaurants_apps/widget/loaddata_error.dart';
import 'package:restaurants_apps/widget/search_widget.dart';

class MenuListPage extends StatefulWidget {
  static const routeName = '/menu-list';

  const MenuListPage({Key? key}) : super(key: key);

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final ListRestaurantBloc listRestaurantBloc = ListRestaurantBloc(api: Api());

  @override
  void initState() {
    listRestaurantBloc.add(ListRestaurantFetch());
    super.initState();
  }

  @override
  void dispose() {
    listRestaurantBloc.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    listRestaurantBloc.add(ListRestaurantRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: secondaryColor,
        onRefresh: _onRefresh,
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocBuilder(
      bloc: listRestaurantBloc,
      builder: (context, state) {
        if (state is OnFailure) {
          return LoadDataError(
            title: 'Problem Occured',
            subtitle: state.error ?? 'Something Went Wrong',
            bgColor: Colors.red,
            onTap: _onRefresh,
          );
        }
        if (state is ListRestaurantLoaded) {
          if (state.dataList.restaurants.isEmpty) {
            return Center(
              child: Container(
                child: const Text('Tidak ada data ditemukan'),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.dataList.restaurants.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DetailsPage.routeName,
                      arguments: state.dataList.restaurants[index]);
                },
                child: _buildRestaurantItem(
                  context,
                  state.dataList.restaurants[index],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: secondaryColor,
          ),
        );
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
