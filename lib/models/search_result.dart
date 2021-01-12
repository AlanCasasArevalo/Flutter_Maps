import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

class SearchResult {
  final bool canceled;
  final bool manual;
  final LatLng position;
  final String destinationName;
  final String destinationDescription;

  SearchResult({
    @required this.canceled,
      this.manual,
      this.position,
      this.destinationName,
      this.destinationDescription
  });
}
