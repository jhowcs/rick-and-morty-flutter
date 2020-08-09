import 'package:json_annotation/json_annotation.dart';

part 'resident.g.dart';

@JsonSerializable()
class Resident {
  final String characterUrl;

  Resident(this.characterUrl);

  factory Resident.fromJson(Map<String, dynamic> json) =>
      _$ResidentFromJson(json);

  Map<String, dynamic> toJson() => _$ResidentToJson(this);
}