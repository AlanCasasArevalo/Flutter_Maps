part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isMapReady;
  final bool isWantToDrawTrack;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState({
    this.isMapReady = false,
    this.isWantToDrawTrack = true,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool isMapReady,
    bool isWantToDrawTrack,
    Map<String, Polyline> polylines
  }) =>
      new MapState(
          isMapReady: isMapReady ?? this.isMapReady,
          isWantToDrawTrack: isWantToDrawTrack ?? this.isWantToDrawTrack,
          polylines: polylines ?? this.polylines
      );
}
