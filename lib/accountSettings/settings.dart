import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class settings extends StatefulWidget {
  final Function changement;

  const settings({Key key, this.changement}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {


  var niveaux = {"1", "2", "3", "4", "5"};
  String selectedlevel="1";
  String pseudo;
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid:user.uid).user,
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      UserData user = snapshot.data;
      int level = int.parse(selectedlevel);
      return Scaffold(
        appBar: AppBar(
          title: Text("Account"),

        ),
        body: Center(child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 10.0),
                  child: TextFormField(
                    initialValue: user.pseudo,
                    validator: (val) =>
                    val.isEmpty ? 'enter a valid name'  : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.supervised_user_circle),
                      labelText: ('Name'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),

                    ),

                    onChanged: (val) {
                      setState(() => pseudo = val);
                    },
                  ),

                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("level"),
                    DropdownButton<String>(
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
                  ],),
SizedBox(height: 50.0,),
                SizedBox(height: 2.0,),
                FlatButton.icon(onPressed: () async {

                    await DatabaseServices(uid:user.uid).updateUserData(pseudo ?? user.pseudo, level ?? user.level);

                  widget.changement();
                },
                    icon: Icon(Icons.save),
                    label: Text("save new informations"),
                    color: Colors.blueAccent)
              ],
            ),
          ),
        ),
        ),
      );
    }
    else{return Loading();}
      }
    );
  }
}
