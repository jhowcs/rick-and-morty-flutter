import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/model/info.dart';

class Data {
  final Info info;
  final List<Character> results;

  Data({this.info, this.results});

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Character> characterList =
        list.map((e) => Character.fromJson(e)).toList();

    return Data(info: Info.fromJson(json['info']), results: characterList);
  }
}
