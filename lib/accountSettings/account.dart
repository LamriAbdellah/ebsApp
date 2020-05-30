import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class account extends StatefulWidget {
  final Function changement;
  const account({Key key, this.changement}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {

  @override
  Widget build(BuildContext context) {

    final user =Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream:DatabaseServices(uid:user.uid).user,
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("Account"),

            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Divider(
                    color: Colors.grey[800],
                    height: 60.0,
                  ),
                  Text(
                    'NAME',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    user.pseudo,
                    style: TextStyle(
                      color: Colors.amberAccent[200],
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                    ),
                  ),

                  SizedBox(height: 50.0,),
                  Center(
                    child: FlatButton.icon(onPressed: () {
                      widget.changement();
                    },
                      icon: Icon(Icons.edit),
                      label: Text("edit your infomrations"),
                      color: Colors.blueAccent,),
                  ),
                  SizedBox(height: 5.0,),

                ],
              ),
            ),


          );
        }
        else{return Loading();};
      }
    );
  }
}
