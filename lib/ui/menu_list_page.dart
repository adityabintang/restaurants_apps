
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_event.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_state.dart';
import 'package:restaurants_apps/data/api/api.dart';
import 'package:restaurants_apps/utils/styles.dart';
import 'package:restaurants_apps/widget/card_restaurant_widget.dart';
import 'package:restaurants_apps/widget/load_data_error.dart';
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
            return const Center(
              child: Text('Tidak ada data ditemukan'),
            );
          }
          return ListView.builder(
            itemCount: state.dataList.restaurants.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: state.dataList.restaurants[index]);
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
}
