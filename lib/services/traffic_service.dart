import 'package:Flutter_Maps/models/routes_response.dart';
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
  final String _baseURL = 'https://api.mapbox.com/directions/v5/mapbox/';
  final String _apiKey = 'pk.eyJ1IjoiYWxhbmNhc2FzIiwiYSI6ImNranUwbDk1ODhlY3AycmxnMW5qeHNoZjEifQ.gSDnQJjTExY0-saSO01d3Q';

  Future<RoutesResponse> getInitialEndCoordinates(LatLng start, LatLng end, RouteProfile type) async {
    print(start);
    print(end);
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
    final url = '${this._baseURL}${routeProfile}/${coordString}';

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
      print(error);
    }
  }
}
