import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:flutter/material.dart';
import 'recupage.dart';
import 'sendpage.dart';


class chatpage extends StatefulWidget {
  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('eps '),

        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: FlatButton(onPressed: () {},
                  child: Text('chat'
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder : (context)=>recupage()) ),
                  child: Text('recu'),
                ),
              ),
              Expanded(
                child: FlatButton(onPressed: ()  => Navigator.of(context).pushReplacement(MaterialPageRoute(builder : (context)=>sendpage()) ),
                  child: Text('envoyer'),

                ),
              ),

            ]
        ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          //Add Problem
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return new_problm();
          }));
        },
      ),
      );


  }
}
