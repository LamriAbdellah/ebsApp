import 'package:epsapp/inscription_login/Registration.dart';
import 'package:epsapp/inscription_login/connect.dart';
import 'package:flutter/material.dart';

class ecran_principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("eps"),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(child:Text("le logo")),

         FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Connecter();
                    }));},
                  child:Text("Connecter"),
              color: Colors.blue,),


            FlatButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return (inscription());
              }));
            }, child:Text("inscription"),
                color: Colors.red,),
          ],
        ),
      ),
    );
  }
}
