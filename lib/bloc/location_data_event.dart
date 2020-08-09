
import 'package:equatable/equatable.dart';

abstract class LocationDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationDataFetched extends LocationDataEvent {}