import 'package:Flutter_Maps/bloc/my_current_location/my_current_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MyCurrentLocationBloc>().followInitialize();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MyCurrentLocationBloc>().unfollow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<MyCurrentLocationBloc, MyCurrentLocationState>(
        builder: (BuildContext context, state) {
          return _mapBuilder(state);
        },
      ),
    );
  }

  Widget _mapBuilder(MyCurrentLocationState state) {
    return state.isLocationAvailable
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Localizacion Latitud => ${state.location.latitude}'),
              Text('Localizacion Longitud => ${state.location.longitude}'),
            ],
          )
        : Center(child: Text('No hay localizacion aun........'));
  }
}
