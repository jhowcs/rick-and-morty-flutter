import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/model/data.dart';

class CharacterRepository {
  Future<Data> fetchCharacters(int page) async {
    final response =
        await http.get('https://rickandmortyapi.com/api/character/?page=$page');
    if (response.statusCode == 200) {
      return Data.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load characters!');
    }
  }
}
