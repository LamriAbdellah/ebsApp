
import 'package:epsapp/loading.dart';
import 'package:epsapp/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class connecter extends StatefulWidget {
  final Function changement;
  const connecter({Key key, this.changement}) : super(key: key);
  @override
  _connecterState createState() => _connecterState();
}

class _connecterState extends State<connecter> {
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String eroor ="";
  //storing the val of the forms
  String email= "";
  String password ="";
  final  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      appBar: AppBar(
        title: Text('sign in'),
actions: <Widget>[
  FlatButton.icon(onPressed: ()=>widget.changement(), icon: Icon(Icons.person_add), label:Text("inscption")),

],
      ),
      body: Container(

        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
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

                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    validator: (val)=> val.isEmpty ? 'enter an password' :null,
                    onChanged: (val) {  setState(()=>password=val);
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.vpn_key),
                      labelText:'password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    obscureText:true,
                  ),
                ),
                SizedBox(height: 10.0,),
                //connecter apres entrer lemail et mod de pass
                RaisedButton(onPressed:() async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.singIn(email, password);

                      setState(() { loading = false;
                      eroor=result;

                      });

                  };
                  },
                  padding:EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  color:Colors.blue,
                  child: Text('sign in'),
                ),
                SizedBox(height: 20.0,),
                Text(eroor, style: TextStyle(color: Colors.red),),
                // aller a la page dinscprtion
              ],
            ),
          ),


        ),
      ),
    );

  }
}

