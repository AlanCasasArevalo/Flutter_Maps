part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState> (
      builder: (context, state) {
        if (state.manualSelection) {
          return Container();
        } else {
          return FadeInDown(child: _buildSearchBar(context));
        }
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: size.width,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            final location = context.read<MyCurrentLocationBloc>().state.location;
            final searchHistory = context.read<SearchBloc>().state.searchHistory;
            final SearchResult result = await showSearch(
                context: context,
                delegate: SearchDestination(proximity: location, searchHistory: searchHistory),
            );
            this._searchResults(context, result, location);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)
                )
              ]
            ),
            child: Text(Constants.searchBarPlaceholder),
          ),
        ),
      ),
    );
  }

  void _searchResults(BuildContext context, SearchResult result, LatLng location) async {
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    final trafficService = new TrafficService();

    if(result.canceled) return;
    if (result.manual) {
      _searchBloc.add(OnPinMarkedActivated());
      return;
    }

    final start = location;
    final end = result.position;

    // final drivingTraffic = await trafficService.getInitialEndCoordinates(start, end, RouteProfile.driving_traffic);
    final driving = await trafficService.getInitialEndCoordinates(start, end, RouteProfile.driving);
    // final cycling = await trafficService.getInitialEndCoordinates(start, end, RouteProfile.cycling);
    // final walking = await trafficService.getInitialEndCoordinates(start, end, RouteProfile.walking);

    final geometry = driving.routes[0].geometry;
    final duration = driving.routes[0].duration;
    final distance = driving.routes[0].distance;
    
    final points = PolylineThirdParty.Polyline.Decode(encodedString: geometry, precision: 6);
    
    final List<LatLng> coordinates = points.decodedCoords.map((point) => LatLng(point[0], point[1])).toList();
    // TODO: Arreglar el searchbar cuando buscas un lugar falta el nombre del destino como se hace en el pin_marker =>     final endCoordinatesInformation = await _trafficService.getCoordinatesInformation(end);
    // _mapBloc.add(OnLocationUserSelected(coordinates: coordinates, distance: distance, duration: duration, destinationName: ));

    _searchBloc.add(OnAddSearchHistory(searchHistory: result));

    // Navigator.of(context).pop();
  }
}
