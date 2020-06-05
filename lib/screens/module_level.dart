import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ModulesLevel extends StatefulWidget {
  @override
  _ModulesLevelState createState() => _ModulesLevelState();
}

class _ModulesLevelState extends State<ModulesLevel> {
  bool loading=false;
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

            return loading ? Loading(): Scaffold(
              appBar: AppBar(
                title: Text("Account"),

              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                child: Center(child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text("please rate your level in this modules"),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Text("algorithme"),
                            Slider(
                              value: (algo ?? 1).toDouble(),
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
                          setState(() => loading = true);

                          await DatabaseServices(uid:user.uid).updateUserData(user.pseudo ?? user.pseudo, algo ?? user.algo,analyse ?? user.analyse,
                            algebre ?? user.algebre,elect ?? user.elect,mecanq ?? user.mecanq,poo ?? user.poo,);

                          Navigator.pop(context, MaterialPageRoute(builder: (context) {
                            return null;
                          }));

                          Navigator.pop(context, MaterialPageRoute(builder: (context) {
                            return null;

                          }));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return Wrapper(index: 0,);

                          }));
                          setState(() => loading = true);
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
