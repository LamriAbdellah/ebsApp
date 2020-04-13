import 'package:epsapp/accountSettings/account.dart';
import 'package:epsapp/accountSettings/settings.dart';
import 'package:flutter/material.dart';

class accountSettings extends StatefulWidget {
  @override
  _accountSettingsState createState() => _accountSettingsState();
}

class _accountSettingsState extends State<accountSettings> {
  bool show = true;
  void changement(){
    setState(() => show= !show);
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return account(changement:changement);
    } else {
      return settings(changement:changement);
    }
  }
}