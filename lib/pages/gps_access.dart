import 'package:Flutter_Maps/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccessPage extends StatefulWidget {
  @override
  _GpsAccessPageState createState() => _GpsAccessPageState();
}

class _GpsAccessPageState extends State<GpsAccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // TODO: Verificar permisos
                final status = await Permission.location.request();
                print('');
                this.gpsAccess(status);
              })
        ],
      ),
    ));
  }

  void gpsAccess(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, Constants.homePageRouteName);
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:
        openAppSettings();
    }
  }
}
