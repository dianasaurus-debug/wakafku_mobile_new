import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/screens/welcome/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    startSpashScreen();
  }


  startSpashScreen() async {
    var duration = const Duration(seconds: 6);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 3);
    // if (firstTime != null && !firstTime) {// Not first time
      return Timer(duration, () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return OnBoarding();
        }));
      });
    // } else {// First time
    //   prefs.setBool('first_time', false);
    //   return Timer(duration, () {
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
    //       return HomePage();
    //     }));
    //   });
    // }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/bwi-logo.png',
                    width: (1 / 2) * MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            )));
  }
}
