part of 'map_bloc.dart';

@immutable
abstract class  MapEvent {}

class OnMapReady extends MapEvent {
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;
  OnLocationUpdate(this.location);
}

class OnDrawTrack extends MapEvent {
}

class OnFollowLocationChange extends MapEvent {
}

class OnMapChangeLocation extends MapEvent {
  final LatLng location;
  OnMapChangeLocation(this.location);
}

class OnLocationUserSelected extends MapEvent {
  final List<LatLng> coordinates;
  final double distance;
  final double duration;

  OnLocationUserSelected({this.coordinates, this.distance, this.duration});
}

