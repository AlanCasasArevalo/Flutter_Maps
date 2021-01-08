import 'package:Flutter_Maps/pages/loading.dart';
import 'package:Flutter_Maps/routes/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: getApplications(),
    );
  }
}
