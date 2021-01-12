part of 'widgets.dart';

class PinMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
              icon: Icon(Icons.arrow_back, color: Colors.black87,),
              onPressed: () {
                // TODO: Hacer algo con el boton de regresar
              },
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -13),
              child: Icon(Icons.location_on, size: 50,)
          ),
        ),
        // Boton de confirmar destino
        Positioned(
          bottom: 50,
          left: 40,
          child: MaterialButton(
            minWidth: size.width - 120,
            child: Text(Constants.pinMarkerDestinationConfirmation, style: TextStyle(color: Colors.white),),
            color: Colors.black87,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              // TODO: Hacer algo
            },
          ),
        )
      ],
    );
  }

}