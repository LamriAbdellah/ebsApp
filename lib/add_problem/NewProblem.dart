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
      backgroundColor: Color(0xffFCFAF1),
        appBar: AppBar(
          backgroundColor:Color(0xff1E3F63),
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
          title: Text('Description de problème',style:TextStyle(fontFamily: 'Lora',)),
        ),
        body: GestureDetector(
          onTap:()=>FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[

              Text("Module",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 10,
                      fontFamily: 'Lora',

                      fontSize: 16)),
              Center(
                heightFactor: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal:16 ),
                  decoration:BoxDecoration(color:Colors.grey[300],
                  borderRadius:BorderRadius.circular(40),
                    boxShadow:[
                      BoxShadow(
                        color: Color(0xff077893),
                        offset: const Offset(0.3,0.3),
                        blurRadius: 4.0,
                        spreadRadius: 1.5
                      ),
                    ]
                  ),
                  child: DropdownButton<String>(

                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                    underline: SizedBox(),
                    items: modules.map((String dropDownStringItem) {

                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,style:TextStyle(fontFamily: 'Lora',),),
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
              ),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextFormField(

                  textCapitalization:TextCapitalization.sentences ,
                  controller: problemDescription,
                  decoration: const InputDecoration(
                    border: InputBorder.none,

                    icon: Icon(Icons.filter_frames),
                    hintText: 'Enterez une briève descréption de problème',
                    hintStyle: TextStyle(fontFamily: 'Lora',),
                    labelText: 'Objet :',
                    labelStyle:TextStyle(fontFamily: 'Lora',)
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
                      border: Border.all(width: 2, color: Color(0xff1E3F63)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                  style:TextStyle(fontFamily: 'Lora',),
                    controller: problemDetails,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                      fillColor:Colors.white,
                      filled: true,
                      hintText: "Expliquez votre problème...",
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
                        padding: EdgeInsets.all(10.0),
                        color: Color(0xff077893),
                        minWidth: 170,
                        height: 20,
                        elevation: 6,
                        shape: StadiumBorder(),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 15,
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
        ),
      );

  }
}


passSelctedModule(String module){

  selectedModule.selected_module=module;
}