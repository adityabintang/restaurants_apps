import 'package:flutter/material.dart';
import 'package:restaurants_apps/model/restaurant.dart';
import 'package:restaurants_apps/ui/details_page.dart';


class MenuListPage extends StatefulWidget {
  static const routeName = '/menu-list';

  const MenuListPage({Key? key}) : super(key: key);

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  List<Restaurant>? restaurant;
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < restaurant!.length; i++) {
            if (restaurant![i].name.contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: !_searchBoolean
              ? const Text('Restaurant App')
              : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                          _searchIndexList = [];
                        });
                      })
                ]
              : [
                  IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      })
                ]),
      body: !_searchBoolean ? _buildList(context) : _searchListView(),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, DetailsPage.routeName,
                  arguments: restaurant![index]);
            },
            child: _buildRestaurantItem(
              context,
              restaurant![index],
            ),
          );
        });
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future:
          DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
      builder: (context, snapshot) {
        restaurant = parseRestaurant(snapshot.data);
        return ListView.builder(
          itemCount: restaurant?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailsPage.routeName,
                    arguments: restaurant![index]);
              },
              child: _buildRestaurantItem(
                context,
                restaurant![index],
              ),
            );
          },
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
    return Row(
      children: [
        Hero(
          tag: restaurant.pictureId.toString(),
          child: Image.network(
            restaurant.pictureId.toString(),
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
                  restaurant.name,
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
                      restaurant.city,
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
}
