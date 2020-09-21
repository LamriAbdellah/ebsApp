import 'dart:io';
import 'package:epsapp/guide/intro_page.dart';
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
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage(Case: 0,),
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/20200921_214857.gif"))
      // FlareActor("assets/New File 4 (4).flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"Untitled"),
    );
  }
}