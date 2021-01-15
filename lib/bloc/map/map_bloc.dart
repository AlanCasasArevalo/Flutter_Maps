import 'dart:async';
import 'dart:convert';

import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/helpers/helpers.dart';
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
      color: Colors.transparent,
      width: 4);

  Polyline _routeDestination = Polyline(
      polylineId: PolylineId(Constants.polylineRouteDestinationName),
      color: Colors.blueAccent,
      width: 4);

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
    } else if (event is OnMapChangeLocation) {
      yield* this._onMapChangeLocation(event);
    } else if (event is OnLocationUserSelected) {
      yield* this._onLocationUserSelected(event);
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

  Stream<MapState> _onMapChangeLocation(OnMapChangeLocation event) async* {
    yield state.copyWith(centralLocation: event.location);
  }

  Stream<MapState> _onLocationUserSelected(
      OnLocationUserSelected event) async* {
    this._routeDestination =
        this._routeDestination.copyWith(pointsParam: event.coordinates);

    final currentPolylines = state.polylines;
    currentPolylines[Constants.polylineRouteDestinationName] =
        this._routeDestination;

    // Initial marker
    // final initialIcon = await getImageAssetMarker();
    // final destinationIcon = await getImageAssetMarkerFromURL();

    // Markers
    final duration = (event.duration / 60).floor();
    final initialIcon = await getStartIconMarker(duration);
    final startMarker = new Marker(
        anchor: Offset(0.0, 1.0),
        icon: initialIcon,
        markerId: MarkerId(Constants.markerRouteStart),
        position: event.coordinates[0],
        infoWindow: InfoWindow(
            onTap: () {},
            title: Constants.startWindowInformationTitle,
            snippet: Constants.startWindowInformationSnippet +
                '$duration ${Constants.startWindowInformationDuration}',
            anchor: Offset(1.0, 1.0)));

    final kilometers = (event.distance / 1000);
    final distanceRounded = (kilometers * 100).floor().toDouble();
    final distance = distanceRounded / 100;

    final destinationIcon =
        await getDestinationIconMarker(distance, event.destinationName);

    final endMarker = new Marker(
        anchor: Offset(0.0, 0.90),
        icon: destinationIcon,
        markerId: MarkerId(Constants.markerRouteDestination),
        position: event.coordinates.last,
        infoWindow: InfoWindow(
          title: event.destinationName,
          snippet: Constants.destinationWindowInformationSnippet +
              '$distance ${Constants.destinationWindowInformationDistance}',
        ));

    final newMarkers = {...state.markers};
    newMarkers[Constants.markerRouteStart] = startMarker;
    newMarkers[Constants.markerRouteDestination] = endMarker;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _googleMapController
          .showMarkerInfoWindow(MarkerId(Constants.markerRouteDestination));
    });

    yield state.copyWith(polylines: currentPolylines, markers: newMarkers);
  }
}
