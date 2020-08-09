import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Locations {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  Locations(this.id, this.name, this.type, this.dimension, this.residents,
      this.url, this.created);

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}
