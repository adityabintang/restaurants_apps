import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_event.dart';
import 'package:restaurants_apps/bloc/restaurant/bloc_state.dart';
import 'package:restaurants_apps/data/api/api.dart';

class ListRestaurantBloc extends Bloc<ListRestaurantEvent, RestaurantState> {
  final Api api;

  ListRestaurantBloc({required this.api}) : super(OnLoading());

  RestaurantState get initialState => OnLoading();

  @override
  Stream<RestaurantState> mapEventToState(ListRestaurantEvent event) async* {
    final currentState = state;
    if (event is ListRestaurantFetch) {
      try {
        if (currentState is OnLoading) {
          final dataList = await api.fetchList();
          yield ListRestaurantLoaded(
            dataList: dataList,
          );
        }
        if (currentState is ListRestaurantLoaded) {
          final dataList = await api.fetchList();
          yield dataList.restaurants.isEmpty
              ? currentState.copyWith()
              : ListRestaurantLoaded(dataList: dataList);
        }
      } catch (err) {
        print(err);
        yield OnFailure(error: err.toString());
      }
    }
    if (event is DetailRestaurantFetch) {
      try {
        if (currentState is OnLoading) {
          final dataList = await api.fetchDetailsList(event.id ?? "");
          yield DetailRestaurantLoaded(
            dataList: dataList,
          );
        }
        if (currentState is DetailRestaurantLoaded) {
          final dataList = await api.fetchDetailsList(event.id ?? "");
          yield dataList.restaurant == null
              ? currentState.copyWith()
              : DetailRestaurantLoaded(
                  dataList: dataList,
                );
        }
      } catch (err) {
        print(err);
        yield OnFailure(error: err.toString());
      }
    }
    if (event is ListRestaurantRefresh) {
      try{
        yield OnLoading();
        final dataList = await api.fetchList();
        yield ListRestaurantLoaded(
          dataList: dataList,
        );
      }catch(err){
        print(err);
        yield OnFailure(error: err.toString());
      }
    }
  }
}
