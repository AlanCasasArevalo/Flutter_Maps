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
        Center(
          child: Transform.translate(
              offset: Offset(0, -13),
              child: Icon(
                Icons.location_on,
                size: 50,
              )),
        ),
        // Boton de confirmar destino
        Positioned(
          bottom: 50,
          left: 40,
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
            },
          ),
        )
      ],
    );
  }
}
