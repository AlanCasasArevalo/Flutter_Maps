import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_current_location_event.dart';
part 'my_current_location_state.dart';

class MyCurrentLocationBloc extends Bloc<MyCurrentLocationEvent, MyCurrentLocationState> {
  MyCurrentLocationBloc() : super(MyCurrentLocationState());

  @override
  Stream<MyCurrentLocationState> mapEventToState(MyCurrentLocationEvent event) async* {
    throw UnimplementedError();
  }

}