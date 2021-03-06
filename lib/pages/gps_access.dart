import 'package:Flutter_Maps/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccessPage extends StatefulWidget {
  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage> with WidgetsBindingObserver {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isFinishPreviousNavigation = false;

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
    if (state == AppLifecycleState.resumed && await Permission.location.isGranted) {
      Navigator.pushReplacementNamed(context, Constants.loadingPageRouteName);
    }  
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('GpsAccess Page!!!!'),
          MaterialButton(
            padding: EdgeInsets.all(14),
              child: Text(
                'Solicitar Accesso',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 2,
              splashColor: Colors.transparent,
              onPressed: () async {
                isFinishPreviousNavigation = true;
                final status = await Permission.location.request();
                await this.gpsAccess(status);
                isFinishPreviousNavigation = false;
              })
        ],
      ),
    ));
  }

  Future gpsAccess(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, Constants.loadingPageRouteName);
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();
    }
  }
}
