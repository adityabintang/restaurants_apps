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
