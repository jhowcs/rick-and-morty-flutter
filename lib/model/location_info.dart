import 'package:json_annotation/json_annotation.dart';

part 'location_info.g.dart';

@JsonSerializable()
class LocationInfo {
  final int count;
  final int pages;
  final String next;
  final String prev;

  LocationInfo(this.count, this.pages, this.next, this.prev);

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}
