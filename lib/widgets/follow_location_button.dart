part of 'widgets.dart';

class FollowLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return BlocBuilder<MapBloc, MapState>(builder: (context, state) => _buttonBuilder(context, state));
  }

  Widget _buttonBuilder (BuildContext mainContext, MapState state) {
    final _mapBloc = BlocProvider.of<MapBloc>(mainContext);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            state.followLocation
                ? Icons.directions_run
                : Icons.accessibility_new,
            color: Colors.black87,
          ),
          onPressed: () {
            _mapBloc.add(OnFollowLocationChange());
          },
        ),
      ),
    );
  }
}
