part of 'my_current_location_bloc.dart';

@immutable
class  MyCurrentLocationState {
  final bool follow;
  final bool isLocationAvailable;
  final LatLng location;

  MyCurrentLocationState({this.follow = true, this.isLocationAvailable = false, this.location});

  MyCurrentLocationState copyWith({
    bool follow,
    bool isLocationAvailable,
    LatLng location
  }) => new MyCurrentLocationState(
    follow: follow ?? this.follow,
    isLocationAvailable: isLocationAvailable ?? this.isLocationAvailable,
    location: location ?? this.location
  );
}