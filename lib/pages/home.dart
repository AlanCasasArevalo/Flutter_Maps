import 'package:Flutter_Maps/bloc/map/map_bloc.dart';
import 'package:Flutter_Maps/bloc/my_current_location/my_current_location_bloc.dart';
import 'package:Flutter_Maps/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<MyCurrentLocationBloc>(context, listen: false)
        .followInitialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<MyCurrentLocationBloc>(context, listen: false).unfollow();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<MyCurrentLocationBloc>(context, listen: false).unfollow();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          BlocBuilder<MyCurrentLocationBloc, MyCurrentLocationState>(
            builder: (BuildContext context, state) {
              return _mapBuilder(state);
            },
          ),
          Positioned(
            top: 15,
              child: SearchBar()
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LocationButton(),
          FollowLocationButton(),
          MyRouteButton(),
        ],
      ),
    );
  }

  Widget _mapBuilder(MyCurrentLocationState state) {
    if (state.isLocationAvailable == false)
      return Center(child: Text('No hay localizacion aun........'));

    final _mapBloc = BlocProvider.of<MapBloc>(context, listen: false);
    _mapBloc.add(OnLocationUpdate(state.location));

    CameraPosition initialCameraPosition = CameraPosition(
        target: state.location,
        bearing: 0,
        // Inclinacion del mapa
        tilt: 0,
        // Cuanto menor sea el zoom mas zona se ve del mapa
        zoom: 17);
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: _mapBloc.mapInitialize,
      // Este parametro es para trazar la ruta seguida por el usuario
      polylines: _mapBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        _mapBloc.add(OnMapChangeLocation(cameraPosition.target));
      },
    );
  }
}
