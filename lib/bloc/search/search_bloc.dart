import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'search_event.dart';

part 'search_state.dart';

class SearchBloc
    extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnPinMarkedActivated) {
      yield state.copyWith(manualSelection: true);
    } else if (event is OnPinMarkedDeactivated) {
      yield state.copyWith(manualSelection: false);
    }
  }
}
