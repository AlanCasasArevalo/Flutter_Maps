import 'dart:async';
import 'package:Flutter_Maps/models/search_result.dart';
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
    } else if (event is OnAddSearchHistory) {
      yield* this._onAddSearchHistory(event);
    }
  }

  Stream<SearchState> _onAddSearchHistory(OnAddSearchHistory event) async* {
    final exists = state.searchHistory.where((search) => search.destinationName == event.searchHistory.destinationName).length;
    if (exists == 0) {
      final newHistory = [...state.searchHistory, event.searchHistory];
      yield state.copyWith(searchHistory: newHistory);
    }
  }

}
