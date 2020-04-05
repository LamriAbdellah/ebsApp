import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'ProblemList.dart';


class new_problm extends StatefulWidget {
  @override
  new_problmState createState() => new_problmState();
}


class new_problmState extends State<new_problm> {
  var modules = {"Algo", "Archi", "Analyse", "Algebre", "Proba"};
  var niveaux = {"1", "2", "3", "4", "5"};

  //Output values :
  var selecteditem = "Algo";
  var selectedlevel = "1";
  final problemDescription = TextEditingController();
  final problemDetails = TextEditingController();

  List<Problem> problems = [];

  /////
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
          title: Text('Problem Description of me'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text("Module",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 5,
                    fontStyle: FontStyle.italic,
                    fontSize: 16)),
            Center(
              heightFactor: 1,
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 40,
                underline: SizedBox(),
                items: modules.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String selected) {
                  setState(() {
                    this.selecteditem = selected;
                  });
                  //send Selected to backend to treat later.
                },
                value: selecteditem,
              ),
            ),
            Text("Problem level",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 5,
                    fontStyle: FontStyle.italic,
                    fontSize: 16)),
            Center(
              heightFactor: 1,
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 40,
                underline: SizedBox(),
                items: niveaux.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String selectedlvl) {
                  setState(() {
                    this.selectedlevel = selectedlvl;
                  });
                  //send to backend to treat later.
                },
                value: selectedlevel,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                controller: problemDescription,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.filter_frames),
                  hintText: 'Enter a brief description of your Problem',
                  labelText: 'Problem Title :',
                ),
                validator: (String value) {
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.indigoAccent),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: TextField(
                  controller: problemDetails,
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: "Explain your Problem",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: MaterialButton(
                      padding: EdgeInsets.all(5.0),
                      color: Colors.indigo,
                      minWidth: 170,
                      height: 20,
                      elevation: 6,
                      shape: StadiumBorder(),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Problem problem = new Problem(selecteditem, selectedlevel,
                            problemDescription.text, problemDetails.text);
                        problems.add(problem);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProblemList(pList: problems)));
                      },
                    ),
                  ),


                ],
              ),
            )
          ]),
        ),
      );

  }
}

class Problem {
  String desc;
  String details;
  String lvl;
  String module;

  Problem(String module, String lvl, String desc, String details) {
    this.module = module;
    this.lvl = lvl;
    this.desc = desc;
    this.details = details;
  }
}
