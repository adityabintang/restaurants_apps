import 'package:restaurants_apps/utils/general_function.dart';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Menus? menus;
  List<Category>? categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
    required this.categories
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = convertToDouble(json['rating']);
    menus = json["menus"] == null
        ? null
        : Menus.fromJson(json["menus"]);
    categories = json["categories"] == null
        ? []
        : List<Category>.from(
        json["categories"]!.map((x) => Category.fromJson(x)));
  }
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  final List<Category>? foods;
  final List<Category>? drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: json["foods"] == null
        ? []
        : List<Category>.from(
        json["foods"]!.map((x) => Category.fromJson(x))),
    drinks: json["drinks"] == null
        ? []
        : List<Category>.from(
        json["drinks"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": foods == null
        ? []
        : List<dynamic>.from(foods!.map((x) => x.toJson())),
    "drinks": drinks == null
        ? []
        : List<dynamic>.from(drinks!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.name,
  });

  final String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}