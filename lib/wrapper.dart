import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/home/accueil.dart';
import 'package:epsapp/Register_And_Login/ecran_principal.dart';
import 'package:epsapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epsapp/services/database.dart';
import 'dart:async';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
class Wrapper extends StatefulWidget {

  Wrapper({Key key, this.index}) : super(key: key);

  final int index;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  QuerySnapshot SnapchatUserInfo;

  final DatabaseFonctions DataGet = DatabaseFonctions();



  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //return ecran principal ou accuiel
    if (user == null) {
      return ecran_principal();
    }
    else {

      return accueil(index: widget.index);

    };
  }


}


