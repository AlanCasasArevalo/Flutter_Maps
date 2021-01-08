import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/helpers/helpers.dart';
import 'package:Flutter_Maps/pages/home.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalScaffoldKey,
        body: FutureBuilder(
          future: this.checkGPSAndLocationsPermission(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            );
          },)
    );
  }


  Future checkGPSAndLocationsPermission(BuildContext context) async {
    // TODO: Comprobar los persmisos de gps
    // TODO: GPS Activo
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, navigationFadeIn(context, HomePage()));
      // Navigator.pushReplacementNamed(context, Constants.homePageRouteName);
    });
  }
}
