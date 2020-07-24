import 'dart:async';

import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/model/data.dart';
import 'package:rxdart/rxdart.dart';

class CharacterBloc {
  final _repository;
  final _characterFetcher = PublishSubject<List<Character>>();
  final _list = List<Character>();
  int _paginationIndex = 1;
  int _maxPage = -1;
  Timer _debounceTimer;
  final int _searchDelay;

  CharacterBloc(this._repository, this._searchDelay);

  Stream<List<Character>> get characters => _characterFetcher.stream;

  fetchCharacters() async {
    Data dataModel = await _repository.fetchCharacters(_paginationIndex);

    if (dataModel != null) {
      _paginationIndex++;
      _maxPage = dataModel.info.pages;

      _list.addAll(dataModel.results.toList());
      _characterFetcher.sink.add(_list);
    }
  }

  dispose() {
    _characterFetcher.close();
  }

  bool hasReachedEnd() => _paginationIndex > _maxPage;

  void searchOnListAlreadyFetched(String query) async {
    if (query.isEmpty) {
      _characterFetcher.sink.add(_list);
    } else {
      if (_debounceTimer != null) _debounceTimer.cancel();

      _debounceTimer = Timer(Duration(milliseconds: _searchDelay), () {
        final searchList = List<Character>();
        searchList.addAll(filteredList(query));
        _characterFetcher.sink.add(searchList);
      });
    }
  }

  Iterable<Character> filteredList(String query) {
    return _list.where(
        (element) => element.name.toUpperCase().contains(query.toUpperCase()));
  }
}
