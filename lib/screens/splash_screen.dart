import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'dart:async';

import 'package:namer_app/screens/generator_page.dart';

//import 'package:namer_app/main.dart';
//import 'package:namer_app/screens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    //sets the timer for the duration of the splashscreen before being pushed to the next screen
    var duration = Duration(seconds: 2);
    return Timer(duration, navigateToDeviceScreen);
  }

  //pushes to MyHomePage route
  navigateToDeviceScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color of the background for the splash screen
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //title and subtext for the splash screen
              Text(
                "WORDPAIR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              Text(
                "Word Pair Generator",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
