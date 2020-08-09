import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_info.dart';
import 'locations.dart';

part 'location_data.g.dart';

@JsonSerializable()
class LocationData extends Equatable {
  final LocationInfo info;
  final List<Locations> results;

  LocationData({this.info, this.results});

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataToJson(this);

  @override
  List<Object> get props => [info.next, info.prev];

  @override
  String toString() {
    return '${info.count} ${results.length}';
  }
}