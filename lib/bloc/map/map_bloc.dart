import 'dart:async';
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
      add(OnMapReady());
    } else {
    }
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(
        isMapReady: true
      );
    }  
  }

}
