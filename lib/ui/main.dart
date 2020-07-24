import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/network/character_repository.dart';
import 'package:rick_and_morty/ui/custom_loader.dart';
import 'package:rick_and_morty/ui/detail.dart';

import '../bloc/character_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  final _bloc = CharacterBloc(CharacterRepository());

  @override
  void initState() {
    super.initState();
    _bloc.fetchCharacters();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _bloc.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _bloc.fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rick And Morty'),
        ),
        body: StreamBuilder(
            stream: _bloc.characters,
            builder: (context, AsyncSnapshot<List<Character>> snapshot) {
              if (snapshot.hasData) {
                return Column(children: <Widget>[
                  Expanded(child: buildCharacterList(snapshot.data)),
                ]);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget buildCharacterList(List<Character> characterList) {
    return ListView.separated(
        controller: _scrollController,
        separatorBuilder: (BuildContext _context, _index) => Divider(),
        itemCount: characterList.length <= 0 ? 0 : characterList.length + 1,
        itemBuilder: (BuildContext _context, int position) {
          return position >= characterList.length
              ? _loadMoreProgress()
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        _context,
                        MaterialPageRoute(
                            builder: (_context) => DetailScreen(
                                  character: characterList[position],
                                )));
                  },
                  child: _buildRow(characterList, position),
                );
        });
  }

  Widget _buildRow(List<Character> characterList, int position) {
    print("Draw Row $position");
    return Container(
        margin: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                characterList[position].image,
                height: 60,
                width: 60,
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      characterList[position].name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ))),
          ],
        ));
  }

  Widget _loadMoreProgress() {
    return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: CustomLoader(width: 45.0, height: 45.0),
    );
  }
}
