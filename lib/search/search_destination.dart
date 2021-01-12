import 'package:Flutter_Maps/common/constants.dart';
import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate {

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
    // TODO: Devolver las busquedas
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => this.close(context, null));
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
            // TODO: Devolver las busquedas
            print('Pinchando en colocar pin');
            this.close(context, null);
          },
        )
      ],
    );
  }
}
