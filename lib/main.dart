import 'package:final_flutter_project/covid_19/bloc/covid_event.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'covid_19/bloc/covid_bloc.dart';
import 'covid_19/bloc/covid_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CovidBloc()..add(InitialEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Final Flutter Project',
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/logo.png"),
          nextScreen: CovidWidget(),
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 400,
        ),
      ),
    );
  }
}
