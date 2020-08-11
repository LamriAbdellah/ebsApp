
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xff1E3F63),
              Color(0xff077893),
            ]
        ),


      ),

child: Container(
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        colors: [
          Color(0xff1E3F63),
          Color(0xff077893),



        ]
    ),


  ),
  child:   SpinKitFoldingCube(
    color:Colors.white,
duration:Duration(milliseconds: 1200),
    size: 50.0,
  ),
),
    );
  }
}
