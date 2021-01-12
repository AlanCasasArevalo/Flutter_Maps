part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isMapReady;
  final bool isWantToDrawTrack;
  final bool followLocation;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.isMapReady = false,
    this.isWantToDrawTrack = true,
    this.followLocation = false,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool isMapReady,
    bool isWantToDrawTrack,
    bool followLocation,
    Map<String, Polyline> polylines
  }) =>
      new MapState(
          isMapReady: isMapReady ?? this.isMapReady,
          isWantToDrawTrack: isWantToDrawTrack ?? this.isWantToDrawTrack,
          followLocation: followLocation ?? this.followLocation,
          polylines: polylines ?? this.polylines
      );
}
