import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/model/character.dart';

class DetailScreen extends StatelessWidget {
  final Character character;

  const DetailScreen({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Character', overflow: TextOverflow.ellipsis)),
        body: Container(
          margin: EdgeInsets.all(8),
          height: 140,
          child: Card(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0)),
                  child: Image.network(character.image,
                      height: 140, width: 120, fit: BoxFit.cover),
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              character.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Row(children: <Widget>[
                              Container(
                                width: 10,
                                height: 10,
                                margin: EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getStatusColor()),
                              ),
                              Text(
                                '${character.status} - ${character.specie}',
                              ),
                            ])
                          ],
                        )))
              ],
            ),
          ),
        ));
  }

  Color getStatusColor() {
    var statusColor = Colors.grey;

    switch (character.status.toLowerCase()) {
      case 'alive':
        statusColor = Colors.green;
        break;
      case 'dead':
        statusColor = Colors.red;
        break;
    }

    return statusColor;
  }
}
