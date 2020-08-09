import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/location_bloc.dart';
import 'package:rick_and_morty/bloc/location_data_event.dart';
import 'package:rick_and_morty/bloc/location_data_state.dart';
import 'package:rick_and_morty/model/locations.dart';
import 'package:rick_and_morty/network/api_service.dart';
import 'package:rick_and_morty/ui/custom_loader.dart';

class LocationListUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(service: ApiService.create())..add(LocationDataFetched()),
      child: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _scrollController = ScrollController();
  LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _locationBloc = BlocProvider.of<LocationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationDataState>(
      builder: (context, state) {
        if (state is LocationDataInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LocationDataFailure) {
          print("Has Error");
          return Container();
        }
        if (state is LocationDataSuccess) {
          if (state.locations.isEmpty) {
            print("Is Empty");
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.locations.length
                  ? CustomLoader(width: 45, height: 45)
                  : LocationWidget(result: state.locations[index]);
            },
            itemCount: state.hasReachedMax
                ? state.locations.length
                : state.locations.length + 1,
            controller: _scrollController,
          );
        }

        return Center(
          child: Text('unknown error!'),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      _locationBloc.add(LocationDataFetched());
    }
  }
}

class LocationWidget extends StatelessWidget {
  final Locations result;

  const LocationWidget({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildRow();
  }
  _buildRow() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        height: 140,
        child: Card(
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Planet: ${result.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          'Type: ${result.type}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          'Dimension: ${result.dimension}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        'Residents: ${getResidents(result)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ));
  }

  String getResidents(Locations result) {
    int residents = result.residents.length;

    return residents > 0 ? residents.toString() : 'no residents';
  }
}
