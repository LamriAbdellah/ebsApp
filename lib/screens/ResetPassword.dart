import 'package:epsapp/services/auth.dart';
import 'package:flutter/material.dart';

class Reset_password extends StatefulWidget {
  @override
  _Reset_passwordState createState() => _Reset_passwordState();
}

class _Reset_passwordState extends State<Reset_password> {
  String eroor ="";
  String email;
  final  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reset your password"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
            child: TextFormField(
              validator: (val)=> val.isEmpty ? 'enter an email' :null,
              decoration: InputDecoration(
                prefixIcon:Icon(Icons.email),
                labelText: ('email'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                border: OutlineInputBorder(),

              ),

              onChanged: (val) {
                setState(()=>email=val);
              },
            ),

          ),
          FlatButton(
            onPressed:(){
             dynamic resetresult= _auth.ResetPassword(email);
             setState(() {
               eroor="email sent succefully";
             });
            },
            child: Text("reset your password"),

          ),
        Text(eroor.toString())],
      ),


    );
  }
}
