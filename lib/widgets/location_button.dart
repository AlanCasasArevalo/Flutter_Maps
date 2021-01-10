part of 'widgets.dart';

class LocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _mapBloc = BlocProvider.of<MapBloc>(context);
    final _myLocationBloc = BlocProvider.of<MyCurrentLocationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            final destination = _myLocationBloc.state.location;
            _mapBloc.cameraMove(destination);
          },
        ),
      ),
    );
  }
}
