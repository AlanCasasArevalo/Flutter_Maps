part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isMapReady;
  final bool isWantToDrawTrack;
  final bool followLocation;
  final LatLng centralLocation;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.isMapReady = false,
    this.isWantToDrawTrack = false,
    this.followLocation = false,
    this.centralLocation,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool isMapReady,
    bool isWantToDrawTrack,
    bool followLocation,
    LatLng centralLocation,
    Map<String, Polyline> polylines
  }) =>
      new MapState(
          isMapReady: isMapReady ?? this.isMapReady,
          isWantToDrawTrack: isWantToDrawTrack ?? this.isWantToDrawTrack,
          followLocation: followLocation ?? this.followLocation,
          centralLocation: centralLocation ?? this.centralLocation,
          polylines: polylines ?? this.polylines
      );
}
