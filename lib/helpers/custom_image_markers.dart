part of 'helpers.dart';

Future<BitmapDescriptor> getImageAssetMarker () async {
  final imageResource = await BitmapDescriptor.fromAssetImage(ImageConfiguration(
      devicePixelRatio: 0.05
  ), 'assets/custom-pin.png');
  return imageResource;
}

Future<BitmapDescriptor> getImageAssetMarkerFromURL () async {
  final url = 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png';
  try {
    final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final bytes = response.data;
    final imageCodec = await ui.instantiateImageCodec(bytes, targetHeight: 100, targetWidth: 100);
    final frame = await imageCodec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return await BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  } catch (error) {
    return await BitmapDescriptor.fromAssetImage(ImageConfiguration(
        devicePixelRatio: 2.5
    ), 'assets/custom-pin.png');
  }
}
