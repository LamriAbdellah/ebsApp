import 'package:epsapp/screens/module_level.dart';
import 'package:flutter/material.dart';
class guide extends StatefulWidget {
  @override
  _guideState createState() => _guideState();
}

class _guideState extends State<guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("eps"),),
      body:Column(
        children: <Widget>[
          Center(child: Text("welcome to the guide"),),
          Center(child: FlatButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ModulesLevel();
          }));}, child: Text("enter"),),)
        ],
      )

    );
  }
}
