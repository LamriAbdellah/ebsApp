import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/accountSettings/account.dart';
import 'package:epsapp/accountSettings/settings.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';

class accountSettings extends StatefulWidget {
  @override
  _accountSettingsState createState() => _accountSettingsState();
}

class _accountSettingsState extends State<accountSettings> {
  final DatabaseFonctions DataGet = DatabaseFonctions();
  QuerySnapshot SnapchatUserInfo;

  bool show = true;
  void changement(){
    setState(() => show= !show);
  }
  @override
  void initState() {
    getUserLevelModules();
    super.initState();
  }
  @override
  getUserLevelModules(){
    DataGet.getModulesLevel(Constants.Name)
        .then((val){
      SnapchatUserInfo=val;
      Constants.algo= SnapchatUserInfo.documents[0].data["algo"] ;
      Constants.analyse= SnapchatUserInfo.documents[0].data["analyse"] ;
      Constants.algebre= SnapchatUserInfo.documents[0].data["algebre"] ;
      Constants.elect= SnapchatUserInfo.documents[0].data["elect"] ;
      Constants.mecanq=SnapchatUserInfo.documents[0].data["mecanq"];
      Constants.poo=SnapchatUserInfo.documents[0].data["poo"];
    });

  }
  @override
  Widget build(BuildContext context) {
    if (show) {
      getUserLevelModules();
      print(Constants.algo);

      return account(changement:changement);
    } else {
      return settings(changement:changement);
    }
  }
}