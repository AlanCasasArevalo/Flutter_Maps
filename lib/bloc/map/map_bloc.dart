import 'dart:async';
import 'dart:convert';
import 'package:Flutter_Maps/themes/uber_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';
part 'map_event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  void mapInitialize(GoogleMapController googleMapController) {
    if (!state.isMapReady) {
      this._googleMapController = googleMapController;
      this._googleMapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapReady());
    } else {
    }
  }
  
  void cameraMove(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._googleMapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(
        isMapReady: true
      );
    } else if (event is OnLocationUpdate) {
      print(event.location);
    }
  }

}
