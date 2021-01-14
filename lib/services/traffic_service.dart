import 'dart:async';

import 'package:Flutter_Maps/helpers/debouncer.dart';
import 'package:Flutter_Maps/models/routes_response.dart';
import 'package:Flutter_Maps/models/search_response.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum RouteProfile {
  driving,
  walking,
  cycling,
  driving_traffic
}

class TrafficService {
  // Singleton
  TrafficService._privateConstructor();

  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService () {
    return _instance;
  }

  final _dio = new Dio();

  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400 ));

  final StreamController<SearchResponse> _searchSuggestionsController = new StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get suggestionStream =>this._searchSuggestionsController.stream;

  final String _baseDirectionsURL = 'https://api.mapbox.com/directions/v5/mapbox/';
  final String _baseGeocodingURL = 'https://api.mapbox.com/geocoding/v5/mapbox';
  final String _apiKey = 'YOUR_API_KEY';

  Future<RoutesResponse> getInitialEndCoordinates(LatLng start, LatLng end, RouteProfile type) async {
    String routeProfile = '';
    switch (type) {
      case RouteProfile.driving:
        routeProfile = 'driving';
        break;
      case RouteProfile.walking:
        routeProfile = 'walking';
        break;
      case RouteProfile.cycling:
        routeProfile = 'cycling';
        break;
      case RouteProfile.driving_traffic:
        routeProfile = 'driving-traffic';
        break;
    }

    final coordString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseDirectionsURL}${routeProfile}/${coordString}';

    try {
      final response = await this._dio.get(url, queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'steps': 'true',
        'access_token': _apiKey,
        'language': 'es'
      });
      final data = RoutesResponse.fromJson(response.data);
      return data;
    } catch (error) {
    }
  }

  Future<SearchResponse> getSearchAddress(LatLng proximity, String valueToSearch) async {

    final coordString = '${proximity.longitude},${proximity.latitude}';
    final url = '${this._baseGeocodingURL}.places/$valueToSearch.json';
    try {
      final response = await this._dio.get(url, queryParameters: {
        'autocomplete': 'true',
        'proximity': coordString,
        'access_token': _apiKey,
        'language': 'es'
      });
      final searchResponse = searchResponseFromJson(response.data);
      return searchResponse;
    } catch (error) {
      return SearchResponse(features: []);
    }
  }

  void getQuerySuggestions( String valueToSearch, LatLng proximity ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.getSearchAddress(proximity, valueToSearch);
      this._searchSuggestionsController.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = valueToSearch;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());

  }
}
