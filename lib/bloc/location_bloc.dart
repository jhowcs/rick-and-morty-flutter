import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/location_data_event.dart';
import 'package:rick_and_morty/bloc/location_data_state.dart';
import 'package:rick_and_morty/model/location_data.dart';
import 'package:rick_and_morty/network/api_service.dart';

class LocationBloc extends Bloc<LocationDataEvent, LocationDataState> {
  ApiService service;

  LocationBloc({@required this.service}) : super(LocationDataInitial());

  @override
  Stream<LocationDataState> mapEventToState(LocationDataEvent event) async* {
    final currentState = state;

    print(state);
    if (event is LocationDataFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is LocationDataInitial) {
          LocationData locationData = await fetchLocation(1);

          yield LocationDataSuccess(
              locations: locationData.results,
              hasReachedMax: false,
              pages: locationData.info.pages);

          return;
        }

        if (currentState is LocationDataSuccess) {
          int listLength = currentState.locations.length;
          int nextPage = (listLength / 20).round() + 1;

          if (nextPage > currentState.pages) {
            yield currentState.copyWith(hasReachedMax: true);
          } else {
            print('fetching page $nextPage');
            LocationData locationData = await fetchLocation(nextPage);
            yield LocationDataSuccess(
                locations: currentState.locations + locationData.results,
                hasReachedMax: false,
                pages: locationData.info.pages);
          }
        }
      } catch (_) {
        yield LocationDataFailure();
      }
    }
  }

  Future<LocationData> fetchLocation(final int page) async {
    var response = await service.getLocations(page);

    LocationData locationData =
        LocationData.fromJson(json.decode(response.body));
    return locationData;
  }

  bool _hasReachedMax(LocationDataState state) =>
      state is LocationDataSuccess && state.hasReachedMax;
}
