import 'package:Flutter_Maps/bloc/map/map_bloc.dart';
import 'package:Flutter_Maps/bloc/my_current_location/my_current_location_bloc.dart';
import 'package:Flutter_Maps/bloc/search/search_bloc.dart';
import 'package:Flutter_Maps/pages/loading.dart';
import 'package:Flutter_Maps/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MyCurrentLocationBloc(),),
        BlocProvider(create: ( _ ) => MapBloc(),),
        BlocProvider(create: ( _ ) => SearchBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: getApplications(),
      ),
    );
  }
}
