import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/add_problem/problem_class.dart';
import 'package:epsapp/Constances/selected_module.dart';
import 'package:epsapp/add_problem/studentsList.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
class new_problm extends StatefulWidget {
  @override
  new_problmState createState() => new_problmState();
}


class new_problmState extends State<new_problm> {
  QuerySnapshot SnapchatUserInfo;
  final DatabaseFonctions DataGet =DatabaseFonctions();
  var modules = {"Algo", "Analyse", "Algebre", "Electronique", "Mecanique", "POO"};

  //Output values :
  var selecteditem = "Algo";
  final problemDescription = TextEditingController();
  final problemDetails = TextEditingController();


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
                      onPressed: () async {
                        Problem problem = new Problem(selecteditem, problemDescription.text, problemDetails.text);
passSelctedModule(selecteditem);
//pour avoir le niv de lutilisateur dans le module selectioner
                         await DataGet.getUserByName(Constants.Name.toString())
                            .then((val){
                          SnapchatUserInfo=val;
                          Constants.Module_level=SnapchatUserInfo.documents[0].data[selecteditem.toLowerCase()] ;
                        });
                        //navigateur vers la liste des etudents
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    etud_list(problem:problem)));
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


passSelctedModule(String module){

  selectedModule.selected_module=module;
}