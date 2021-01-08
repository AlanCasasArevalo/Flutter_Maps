import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/helpers/helpers.dart';
import 'package:Flutter_Maps/pages/gps_access.dart';
import 'package:Flutter_Maps/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final locationActiveGPS = await Geolocator.isLocationServiceEnabled();

    if (state == AppLifecycleState.resumed && locationActiveGPS) {
      Navigator.pushReplacementNamed(context, Constants.homePageRouteName);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalScaffoldKey,
        body: FutureBuilder(
          future: this.checkGPSAndLocationsPermission(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(child: Text(snapshot.data),);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                ),
              );
            }
          },)
    );
  }

  Future checkGPSAndLocationsPermission(BuildContext context) async {

    // Si el permiso y el gps estan activados
    final gpsPermission = await Permission.location.isGranted;
    final locationActiveGPS = await Geolocator.isLocationServiceEnabled();

    if (gpsPermission && locationActiveGPS) {
      Navigator.pushReplacement(context, navigationFadeIn(context, HomePage()));
    } else if (!gpsPermission) {
      return 'Necesita el permiso de gps para usar la aplicacion';
    } else if (!locationActiveGPS) {
      return 'Active el GPS por favor';
    }
  }
}
