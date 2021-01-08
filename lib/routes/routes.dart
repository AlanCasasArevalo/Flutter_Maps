import 'package:Flutter_Maps/common/constants.dart';
import 'package:Flutter_Maps/pages/gps_access.dart';
import 'package:Flutter_Maps/pages/home.dart';
import 'package:Flutter_Maps/pages/loading.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplications() {
  return routes;
}

final routes = <String, WidgetBuilder>{
  Constants.homePageRouteName: (BuildContext context) => HomePage(),
  Constants.loadingPageRouteName: (BuildContext context) => LoadingPage(),
  Constants.gpsAccessPageRouteName: (BuildContext context) => GpsAccessPage(),
};

MaterialPageRoute<dynamic> Function(RouteSettings)
    getDefaultRouteApplications() {
  return defaultRoute;
}

final defaultRoute = (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => LoadingPage(),
    );
