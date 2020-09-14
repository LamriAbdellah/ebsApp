import 'package:epsapp/wrapper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(

          child: SplashScreen.navigate(name: "assets/New File 4 (4).flr", next: (_) => Wrapper(),
            until: ()=>Future.delayed(Duration(seconds: 0)),
            startAnimation:"Untitled",
            alignment: Alignment.center,
            fit: BoxFit.fill,),
        )

    );
  }
}
