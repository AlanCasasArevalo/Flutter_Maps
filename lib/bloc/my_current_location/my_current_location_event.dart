part of 'my_current_location_bloc.dart';

@immutable
abstract class  MyCurrentLocationEvent {}

class OnLocationChange extends MyCurrentLocationEvent {
  final LatLng location;

  OnLocationChange(this.location);
}