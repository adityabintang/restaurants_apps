import 'package:equatable/equatable.dart';

abstract class ListRestaurantEvent extends Equatable {
  const ListRestaurantEvent();

  @override
  List<Object> get props => [];
}

class ListRestaurantFetch extends ListRestaurantEvent {}

class DetailRestaurantFetch extends ListRestaurantEvent {
  final String? id;

  const DetailRestaurantFetch({required this.id});
}

class ListRestaurantRefresh extends ListRestaurantEvent {}

class DetailRestaurantRefresh extends ListRestaurantEvent {
  final String? id;

  const DetailRestaurantRefresh({required this.id});
}