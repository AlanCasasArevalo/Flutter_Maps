part of 'helpers.dart';

Future<BitmapDescriptor> getImageAssetMarker () async {
  return await BitmapDescriptor.fromAssetImage(ImageConfiguration(
    devicePixelRatio: 2.5
  ), 'assets/custom-pin.png');
}
