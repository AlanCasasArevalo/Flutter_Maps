import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/models/search_response.dart';
import 'package:Flutter_Maps/models/search_result.dart';
import 'package:Flutter_Maps/services/traffic_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  final TrafficService _trafficService;
  final LatLng proximity;

  SearchDestination({this.proximity})
      : this.searchFieldLabel = Constants.searchBarPlaceholderEditing,
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final searchResult = SearchResult(canceled: true);
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, searchResult));
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._buildResultSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.trim().length == 0) {
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
    } else {
      return _buildResultSuggestion();
    }
  }

  Widget _buildResultSuggestion() {
    if (this.query.trim().length < 2) return Container();
    
    this._trafficService.getQuerySuggestions(this.query.trim(), this.proximity);

    return StreamBuilder(
        stream: this._trafficService.suggestionStream,
        builder:
            (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final places = snapshot.data.features;

            if (places.length < 1) {
              return ListTile(
                title: Text('No hay resultados con esa busqueda.'),
              );
            } else {
              return ListView.separated(
                itemCount: places.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final place = places[index];
                  return ListTile(
                    leading: Icon(Icons.place),
                    title: Text(place.placeName),
                    subtitle: Text(place.placeNameEs),
                    onTap: () {
                      this.close(context, SearchResult(
                          canceled: false,
                        manual: false,
                        position: LatLng(place.center[1], place.center[0]),
                        destinationName: place.textEs,
                        destinationDescription: place.placeNameEs
                      ));
                    },
                  );
                },
              );
            }
          }
        });
  }
}
