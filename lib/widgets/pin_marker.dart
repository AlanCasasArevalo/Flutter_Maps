part of 'widgets.dart';

class PinMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.manualSelection ? _PinMarkerBuilder() : Container();
      },
    );
  }
}

class _PinMarkerBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Boton de regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 300),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  _searchBloc.add(OnPinMarkedDeactivated());
                  return;
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
              offset: Offset(0, -13),
              child: BounceInDown(
                child: Icon(
                  Icons.location_on,
                  size: 50,
                ),
              )),
        ),
        // Boton de confirmar destino
        Positioned(
          bottom: 50,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: size.width - 120,
              child: Text(
                Constants.pinMarkerDestinationConfirmation,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black87,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                // TODO: Hacer algo
                print('Confirmar destino');
                this._destinationCalculate(context);
              },
            ),
          ),
        )
      ],
    );
  }

  void _destinationCalculate(BuildContext context) async {
    final _trafficService = new TrafficService();
    final _myCurrentLocationBloc = BlocProvider.of<MyCurrentLocationBloc>(context);
    final _mapBloc = BlocProvider.of<MapBloc>(context);

    final start = _myCurrentLocationBloc.state.location;
    final end = _mapBloc.state.centralLocation;
    final response = await _trafficService.getInitialEndCoordinates(start, end, RouteProfile.driving);

    final geometry = response.routes[0].geometry;
    final duration = response.routes[0].duration;
    final distance = response.routes[0].distance;

    // Decodificar
    final points = PolylineThirdParty.Polyline.Decode(
      encodedString: geometry,
      precision: 6
    ).decodedCoords;

    final List<LatLng> coordList = points.map((point) => LatLng(point[0], point[1])).toList();

    _mapBloc.add(OnLocationUserSelected(
      coordinates: coordList,
      distance: distance,
      duration: duration
    ));
  }
}
