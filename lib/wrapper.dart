import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/home/accueil.dart';
import 'package:epsapp/Register_And_Login/ecran_principal.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/screens/module_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epsapp/services/database.dart';

class Wrapper extends StatelessWidget {

  Wrapper({Key key, this.index}) : super(key: key);

  final int index;

  QuerySnapshot SnapchatUserInfo;
  final DatabaseFonctions DataGet = DatabaseFonctions();


  getUserName(String uid) {
    DataGet.getUserNameByID(uid)
        .then((val){
      SnapchatUserInfo=val;
      Constants.Name= SnapchatUserInfo.documents[0].data["pseudo"] ;
    });
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return ecran principal ou accuiel
    if (user == null) {
      return ecran_principal();
    }
    else {
      getUserName(user.uid);

        return accueil(index: index,uid: user.uid,);}


      }
    }

