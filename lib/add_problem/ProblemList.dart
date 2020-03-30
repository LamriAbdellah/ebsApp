import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NewProblem.dart';

class ProblemList extends StatefulWidget {
  final List<Problem> pList;

  const ProblemList({this.pList, Plist});

  @override
  ProblemListState createState() => ProblemListState();
}

class ProblemListState extends State<ProblemList> {
  @override
  Widget build(BuildContext context) {
    return            ListView.builder(
                itemCount: widget.pList.length,
                itemBuilder: (context, index) {
                  return new Dismissible(
                      onDismissed: (direction) {
                        widget.pList.remove(widget.pList[index]);
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      key: Key(widget.pList[index].toString()),
                      child: Card(
                        elevation: 8.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: tile(widget.pList[index]),
                        ),
                      ));
                });

  }
}

ListTile tile(Problem problem) {
  return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          problem.module,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Text(problem.desc,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontStyle: FontStyle.italic)),
      ),
      trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
}
