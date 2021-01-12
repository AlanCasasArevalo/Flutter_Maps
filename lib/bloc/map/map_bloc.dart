import 'dart:async';
import 'dart:convert';

import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/themes/uber_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  // Polylines

  Polyline _myRoute = Polyline(
      polylineId: PolylineId(Constants.polylineMyRouteName),
      color: Colors.black87,
      width: 4
  );

  void mapInitialize(GoogleMapController googleMapController) {
    if (!state.isMapReady) {
      this._googleMapController = googleMapController;
      this._googleMapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapReady());
    }
  }

  void cameraMove(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._googleMapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(isMapReady: true);
    } else if (event is OnLocationUpdate) {
      yield* this._onLocationUpdate(event);
    } else if (event is OnDrawTrack) {
      yield* this._onDrawTrack();
    } else if (event is OnFollowLocationChange) {
      yield* this._onFollowLocationChange();
    }
  }

  Stream<MapState> _onDrawTrack() async* {
    if (!state.isWantToDrawTrack) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines[Constants.polylineMyRouteName] = this._myRoute;

    yield state.copyWith(
        isWantToDrawTrack: !state.isWantToDrawTrack,
        polylines: currentPolylines);
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async* {

    if (state.followLocation) {
      this.cameraMove(event.location);
    }

    List<LatLng> pointsParam = [...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: pointsParam);

    final currentPolylines = state.polylines;
    currentPolylines[Constants.polylineMyRouteName] = this._myRoute;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _onFollowLocationChange() async* {
    if (!state.followLocation) {
      this.cameraMove(this._myRoute.points.last);
    }
    yield state.copyWith(
      followLocation: !state.followLocation,
    );
  }
}
