import 'package:equatable/equatable.dart';
import 'package:restaurants_apps/data/model/restaurantresults.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class OnLoading extends RestaurantState {}

class OnFailure extends RestaurantState {
  final String? error;

  const OnFailure({this.error});

  @override
  List<Object> get props => [error ?? ""];

  @override
  String toString() => 'Failure { items: $error }';
}

class ListRestaurantLoaded extends RestaurantState {
  final RestaurantResult dataList;

  const ListRestaurantLoaded({
    required this.dataList,
  });

  ListRestaurantLoaded copyWith({
    RestaurantResult? dataList,
  }) {
    return ListRestaurantLoaded(
      dataList: dataList ?? this.dataList,
    );
  }

  @override
  List<Object> get props => [dataList];

  @override
  String toString() =>
      'RestaurantLoaded { data: ${dataList.restaurants.length} }';
}

class DetailRestaurantLoaded extends RestaurantState {
  final RestaurantResult dataList;

  const DetailRestaurantLoaded({
    required this.dataList,
  });

  DetailRestaurantLoaded copyWith({
    RestaurantResult? dataList,
  }) {
    return DetailRestaurantLoaded(
      dataList: dataList ?? this.dataList,
    );
  }

  @override
  List<Object> get props => [dataList];

  @override
  String toString() =>
      'RestaurantLoaded { data: $dataList }';
}

