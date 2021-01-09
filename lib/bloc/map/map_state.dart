part of 'map_bloc.dart';

@immutable
class MapState {
  final bool isMapReady;

  MapState({this.isMapReady = false});

  MapState copyWith({
    bool isMapReady,
  }) =>
      new MapState(isMapReady: isMapReady ?? this.isMapReady);
}
