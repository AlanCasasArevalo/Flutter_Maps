import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/models/search_result.dart';
import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  final String searchFieldLabel;

  SearchDestination(): this.searchFieldLabel = Constants.searchBarPlaceholderEditing;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = SearchResult(canceled: true);
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => this.close(context, searchResult));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text(Constants.searchBarPinTitle),
          onTap: () {
            this.close(context, SearchResult(canceled: false, manual: true));
          },
        )
      ],
    );
  }
}
