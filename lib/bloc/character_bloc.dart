import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/model/data.dart';
import 'package:rxdart/rxdart.dart';

class CharacterBloc {
  final _repository;
  final _characterFetcher = PublishSubject<List<Character>>();
  final _list = List<Character>();
  int _paginationIndex = 1;
  bool isLoading = false;

  CharacterBloc(this._repository);

  Stream<List<Character>> get characters => _characterFetcher.stream;

  fetchCharacters() async {
    isLoading = true;
    Data dataModel = await _repository.fetchCharacters(_paginationIndex);

    if (dataModel != null) _paginationIndex++;

    isLoading = false;

    _list.addAll(dataModel.results.toList());

    _characterFetcher.sink.add(_list);
  }

  dispose() {
    _characterFetcher.close();
  }
}
