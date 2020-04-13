import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:epsapp/add_problem/ProblemList.dart';
import 'package:epsapp/add_problem/studentListMaker.dart';
import 'package:epsapp/home/accueil.dart';
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class etud_list extends StatefulWidget {
  final int level;

  const etud_list({Key key, this.level}) : super(key: key);
  @override
  _etud_listState createState() => _etud_listState();
}

class _etud_listState extends State<etud_list> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<student>>.value(
      value: DatabaseServices().Students,
      child: Scaffold(
          appBar: AppBar(
                title: Text('eps '),

              ),
              body:
              Column(
                children: <Widget>[
                  Expanded(
                    child: studentsListMaker(level: widget.level,),
                  ),
              RaisedButton(onPressed: (){
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProblemList()));
      Navigator.pop(
      context,
      MaterialPageRoute(
      builder: (context) {return null;}));

   Navigator.pop( context ,MaterialPageRoute(builder: (context){return null;}));
                Navigator.pop( context ,MaterialPageRoute(builder: (context){return null;}));
                Navigator.pushReplacement(
      context,
      MaterialPageRoute(
      builder: (context) =>
     Wrapper(index: 1,)));
              },

              child:Text("envoyer"),
      )
                  , ],
              ),

              ),
    );

  }
}
