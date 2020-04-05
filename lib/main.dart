import 'package:epsapp/src/accueil.dart';
import 'package:flutter/material.dart';


void main() => runApp( app());
    class app extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
        home: accueil(index: 0,),
        );
      }
    }





