import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'my_current_location_event.dart';

part 'my_current_location_state.dart';

class MyCurrentLocationBloc
    extends Bloc<MyCurrentLocationEvent, MyCurrentLocationState> {
  MyCurrentLocationBloc() : super(MyCurrentLocationState());
  StreamSubscription<Position> _positionSubscription;

  void followInitialize() {
    Geolocator.isLocationServiceEnabled();

    // Esta escuchando siempre la posicion del usuario
    _positionSubscription = Geolocator.getPositionStream(
      // Opciones de la localicacion
      forceAndroidLocationManager: true,
      distanceFilter: 10,
      desiredAccuracy: LocationAccuracy.high,
      intervalDuration: Duration(seconds: 10),
    ).listen((Position position) {
      print(position);
    });
  }

  void unfollow() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MyCurrentLocationState> mapEventToState(
      MyCurrentLocationEvent event) async* {
    throw UnimplementedError();
  }
}
