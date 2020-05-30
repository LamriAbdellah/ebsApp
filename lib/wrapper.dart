import 'package:epsapp/home/accueil.dart';
import 'package:epsapp/Register_And_Login/ecran_principal.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/screens/module_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  Wrapper({Key key, this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    //return ecran principal ou accuiel
    if (user==null){return ecran_principal();}
    else {return accueil(index: index,);}

  }
}
