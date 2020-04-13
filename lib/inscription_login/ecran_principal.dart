import 'package:epsapp/inscription_login/Registration.dart';
import 'package:epsapp/inscription_login/connect.dart';
import 'package:flutter/material.dart';

class ecran_principal extends StatefulWidget {
  @override
  _ecran_principalState createState() => _ecran_principalState();
}

class _ecran_principalState extends State<ecran_principal> {
  bool show = true;
  void changement(){
    //print(showSignIn.toString());
    setState(() => show= !show);
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return connecter(changement:changement);
    } else {
      return inscription(changement:changement);
    }
  }
}