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
  int algo=1;
  int analyse=1;
  int algebre=1;
  int elect=1;
  int mecanq=1;
  int poo=1;
  String pseudo;
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid:user.uid).user,
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      UserData user = snapshot.data;

      return Scaffold(
        appBar: AppBar(
          title: Text("Account"),

        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
          child: Center(child: Form(
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
                    children: <Widget>[
                      Text("algorithme"),
                      Slider(
                        value: (algo ?? 1).toDouble(),
                        label: "$algo",
                        inactiveColor: Colors.amber[algo?? 100],
                        activeColor:Colors.amber[algo*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => algo = val.round()),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: <Widget>[
                      Text("analyse"),
                      Slider(
                        value: (analyse ?? 1).toDouble(),
                        label: "$analyse",
                        inactiveColor: Colors.amber[analyse?? 100],
                        activeColor:Colors.amber[analyse*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => analyse= val.round()),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.0,),
                  Row(
                    children: <Widget>[
                      Text("algebre"),
                      Slider(
                        label: "$algebre",
                        value: ( algebre ?? 1).toDouble(),
                        inactiveColor: Colors.amber[algebre?? 100],
                        activeColor:Colors.amber[algebre*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => algebre = val.round()),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: <Widget>[
                      Text("electronique"),
                      Slider(
                        label: "$elect",
                        value: (elect ?? 1).toDouble(),
                        inactiveColor: Colors.amber[elect?? 100],
                        activeColor:Colors.amber[elect*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => elect = val.round()),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: <Widget>[
                      Text("mecanqiue"),
                      Slider(
                        label: "$mecanq",
                        value: (mecanq ?? 1).toDouble(),
                        inactiveColor: Colors.amber[mecanq?? 100],
                        activeColor:Colors.amber[mecanq*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => mecanq = val.round()),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  Row(
                    children: <Widget>[
                      Text("poo"),
                      Slider(
                        label: "$poo",
                        value: (poo ?? 1).toDouble(),
                        inactiveColor: Colors.amber[poo?? 100],
                        activeColor:Colors.amber[poo*100 ?? 100],
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        onChanged: (val) => setState(() => poo = val.round()),
                      ),
                    ],
                  ),



SizedBox(height: 50.0,),
                  SizedBox(height: 2.0,),
                  FlatButton.icon(onPressed: () async {

                      await DatabaseServices(uid:user.uid).updateUserData(pseudo ?? user.pseudo,user.email, algo ?? user.algo,analyse ?? user.analyse,
                        algebre ?? user.algebre,elect ?? user.elect,mecanq ?? user.mecanq,poo ?? user.poo,);

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
        ),
      );
    }
    else{return Loading();}
      }
    );
  }
}
