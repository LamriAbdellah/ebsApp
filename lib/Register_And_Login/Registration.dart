import 'package:epsapp/loading.dart';
import 'package:epsapp/screens/guide.dart';
import 'package:epsapp/screens/module_level.dart';
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
import 'package:flutter/material.dart';

class inscription extends StatefulWidget {
  //fonction chargment sert au transfert entre les deux page connecter et inscrire
  final Function changement;
  const inscription({Key key, this.changement}) : super(key: key);

  @override
  _inscriptionState createState() => _inscriptionState();
}

class _inscriptionState extends State<inscription> {



  //confirmation de remplisage des zones
  final _formKey=GlobalKey<FormState>();
  bool loading=false ;
  //variable des zones
  String pseudo="";
  String email="";
  String password="";
  String repassword="";
  String eroor="";

  //variable de firebaseauthen
  final  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        actions: <Widget>[FlatButton.icon(onPressed: (){widget.changement();}, icon: Icon(Icons.person), label:Text("se connecter"))],

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
                    validator: (val)=> val.isEmpty ? 'enter a name' :null,
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.supervised_user_circle),
                      labelText: ('Name'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),

                    ),

                    onChanged: (val) {  setState(()=>pseudo=val);

                    },
                  ),

                ),
                SizedBox(height: 20.0),

                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                      validator: (val)=> val.isEmpty ? 'enter an email' :null,
                    onChanged: (val) {  setState(()=>email=val);
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.email),
                      labelText:'E-mail',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    validator: (val)=> val.isEmpty ? 'enter a password' :null,
                    onChanged: (val) {
                      setState(()=>password=val);
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.lock),
                      labelText:'password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    obscureText:true,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    validator: (val){  if(val.isEmpty)
    return 'repeat the  password';
    if(val != password)
    return ' passwords doesnt match';
    return null;},

    onChanged: (val) {
                      setState(()=>repassword=val);
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.lock),
                      labelText:'password confirmation',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    obscureText:true,
                  ),
                ),

                SizedBox(height: 10.0,),
                RaisedButton(onPressed:() async {
                  if (_formKey.currentState.validate()){

                    setState(() => loading = true);
                   sharingUserInfo.saveuserLoggedInSharedprefences(true);
                   sharingUserInfo.saveuserUserNameSharedprefences(pseudo);
                   sharingUserInfo.saveuserUserEmailSharedprefences(email);
                    dynamic result =await _auth.register(email,password,pseudo,1,1,1,1,1,1);
              //problem de connection ou email forme incorrect
                   setState(() { loading = false;
                eroor=result;
                });
                };
                },
                  padding:EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  color:Colors.blue,
                  child: Text('register'),
                ),
                SizedBox(height: 20.0,),
                Text(eroor, style: TextStyle(color: Colors.red),),
              ],
            ),
          ),


        ),
      ),
    );

  }
}