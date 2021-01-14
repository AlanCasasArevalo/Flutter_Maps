part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool manualSelection;
  final List<SearchResult> searchHistory;

  SearchState({
    this.manualSelection = false,
    List<SearchResult> searchHistory
  }) : this.searchHistory = (searchHistory == null) ? [] : searchHistory;

  SearchState copyWith({
    bool manualSelection,
    List<SearchResult> searchHistory
  }) =>
      new SearchState(
          manualSelection: manualSelection ?? this.manualSelection,
          searchHistory: searchHistory ?? this.searchHistory
      );
}
