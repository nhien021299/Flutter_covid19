import 'package:final_flutter_project/covid_19/covid_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Flutter Project',
      home: AnimatedSplashScreen(
        splash: Image.asset("assets/logo.png"),
        nextScreen: CovidWidget(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize:  400,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}
