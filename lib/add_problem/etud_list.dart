import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:epsapp/add_problem/ProblemList.dart';
import 'package:epsapp/src/accueil.dart';

import 'package:flutter/material.dart';

class etud_list extends StatefulWidget {
  @override
  _etud_listState createState() => _etud_listState();
}

class _etud_listState extends State<etud_list> {
  List<etudient> etudients =[
    etudient("omar",false),etudient("hmed",false), etudient("omar",false),etudient("hmed",false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
              title: Text('eps '),

            ),
            body:
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                        itemCount: etudients.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: CheckboxListTile(
                              value: etudients[index].select,
                              onChanged: (bool value) {
                                setState(() {
                                  etudients[index].select = value;

                                });
                              },
                              title: Text(etudients[index].nom),
                            ),
                          );
                        },
                      ),
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
    builder: (context) =>
    new_problm()));

    Navigator.pop(
    context,
    MaterialPageRoute(
    builder: (context) =>
    accueil(index: 0,)));

              Navigator.pushReplacement(
    context,
    MaterialPageRoute(
    builder: (context) =>
    accueil(index: 1,)));


            },

            child:Text("envoyer"),
    )
                , ],
            ),
      
            );

  }
}
class etudient {
  String nom;
  bool select;


  etudient(String nom,bool select) {
    this.nom = nom;
    this.select=select;

  }

}
