import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/detail.dart';
import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/model/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick And Morty',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RickAndMortyApp(),
    );
  }
}

class RickAndMortyApp extends StatefulWidget {
  @override
  _RickAndMortyAppState createState() => _RickAndMortyAppState();
}

class _RickAndMortyAppState extends State<RickAndMortyApp> {
  bool _isLoading = true;
  int _paginationIndex = 1;
  List<Character> _list = List();

  @override
  void initState() {
    super.initState();
    _fetchCharacters(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rick And Morty'),
        ),
        body: Column(children: <Widget>[
          Expanded(child: buildCharacterList()),
          Container(
            height: _isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(child: new CircularProgressIndicator()),
          ),
        ]));
  }

  _fetchCharacters(int page) {
    http
        .get('https://rickandmortyapi.com/api/character/?page=$page')
        .then((value) => {
              if (value.statusCode == 200)
                {
                  setState(() {
                    var data = Data.fromJson(json.decode(value.body));
                    _list.addAll(data.results.toList());
                    _isLoading = false;
                  })
                }
            });
  }

  Widget buildCharacterList() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchCharacters(++_paginationIndex);
            setState(() {
              _isLoading = true;
            });
          }
          return true;
        },
        child: ListView.separated(
            separatorBuilder: (BuildContext _context, _index) => Divider(),
            itemCount: _list.length <= 0 ? 0 : _list.length,
            itemBuilder: (BuildContext _context, int position) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      _context,
                      MaterialPageRoute(
                          builder: (_context) => DetailScreen(
                                character: _list[position],
                              )));
                },
                child: _buildRow(position),
              );
            }));
  }

  Widget _buildRow(int position) {
    return Container(
        margin: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                _list[position].image,
                height: 60,
                width: 60,
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      _list[position].name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ))),
          ],
        ));
  }
}
