import 'package:flutter/material.dart';
import 'package:rick_and_morty/ui/episodes_list_ui.dart';
import 'package:rick_and_morty/ui/location_list_ui.dart';

import 'character_list_ui.dart';

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
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CharacterListUI(),
    LocationListUI(),
    EpisodesListUI()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick and Morty'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
            ),
            title: Text('Characters'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.place,
            ),
            title: Text('Location'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
            ),
            title: Text('Episodes'),
          ),
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
