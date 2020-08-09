import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/model/locations.dart';

abstract class LocationDataState extends Equatable {
  const LocationDataState();

  @override
  List<Object> get props => [];
}

class LocationDataInitial extends LocationDataState {}

class LocationDataFailure extends LocationDataState {}

class LocationDataSuccess extends LocationDataState {
  final List<Locations> locations;
  final bool hasReachedMax;
  final int pages;

  const LocationDataSuccess({this.locations, this.hasReachedMax, this.pages});

  LocationDataSuccess copyWith(
      {List<Locations> locations, bool hasReachedMax, int pages}) {
    return LocationDataSuccess(
        locations: locations ?? this.locations,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pages: pages ?? this.pages);
  }

  @override
  List<Object> get props => [locations, hasReachedMax];

  @override
  String toString() {
    return 'locations: ${locations.length}, hasReachedMax: $hasReachedMax';
  }
}
