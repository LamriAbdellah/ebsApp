import 'dart:io';

import 'package:epsapp/guide/MainGuideScreen.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  File flare;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor("assets/New File 4 (4).flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"Untitled"),
    );
  }
}