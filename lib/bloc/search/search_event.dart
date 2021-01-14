part of 'search_bloc.dart';

@immutable
abstract class  SearchEvent {}

class OnPinMarkedActivated extends SearchEvent {}

class OnPinMarkedDeactivated extends SearchEvent {}

class OnAddSearchHistory extends SearchEvent {
  final SearchResult searchHistory;
  OnAddSearchHistory({this.searchHistory});
}