import 'package:Flutter_Maps/bloc/my_current_location/my_current_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

    if (state.isLocationAvailable == false) return Center(child: Text('No hay localizacion aun........'));
    CameraPosition initialCameraPosition = CameraPosition (
      target: state.location,
      bearing: 2,
      tilt: 2,
      zoom: 14
    );
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
    );
  }
}
