import 'package:restaurants_apps/data/model/restaurantresults.dart';

class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  final RestaurantResult result;

  SearchPopulated(this.result);
}

class SearchEmpty extends SearchState {}