
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epsapp/screens/ResetPassword.dart';



class connecter extends StatefulWidget {
  final Function changement;
  const connecter({Key key, this.changement}) : super(key: key);
  @override
  _connecterState createState() => _connecterState();
}

class _connecterState extends State<connecter> {
  QuerySnapshot SnapchatUserInfo;
  final DatabaseFonctions DataGet =DatabaseFonctions();
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

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color(0xff1E3F63),
                  Color(0xff077893),



                ]
            ),


        ),

       child: Column(
         children: <Widget>[
           SizedBox(height: 100,),
           Text("Se connecter",
             style: TextStyle(
               fontSize:30.0,
               fontWeight: FontWeight.bold,
               fontFamily: 'Lora'



             ),
           ),
           SizedBox(height: 50,),

           Expanded(
             child: Container(               decoration: BoxDecoration(

                   gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       colors: [

                         Color(0xffFCFAF1),
                         Color(0xffFCFAF1),

                       ]),
                   borderRadius: BorderRadius.only(topLeft: Radius.elliptical(200,100), topRight: Radius.elliptical(200,100),bottomLeft:Radius.elliptical(200,100),bottomRight:Radius.elliptical(200,100)),
                   
               ),
              child:Form(
                key: _formKey,
                child: SingleChildScrollView(

                  child: Column(
                    children: <Widget>[

                      SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),

                        child: TextFormField(

                          validator: (val)=> val.isEmpty ? 'Adresse e-mail' :null,
                          decoration: InputDecoration(

                            prefixIcon:Icon(Icons.email,color:Colors.grey,),
                            hintText:"Adresse e-mail",

                          hintStyle: TextStyle(color: Colors.grey,
                            fontFamily: 'Moon'
                          ),
                            enabledBorder: OutlineInputBorder(

                              borderRadius:BorderRadius.circular(60),
                              borderSide: BorderSide(color: Colors.white,width: 30),


                            ),
                            border: OutlineInputBorder(

                              borderRadius:BorderRadius.circular(60),


                            ),

                          ),

                          onChanged: (val) {
                            setState(()=>email=val);

                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                        child: TextFormField(
                          validator: (val)=> val.isEmpty ? 'Mot de passe' :null,
                          onChanged: (val) {  setState(()=>password=val);
                          },
                          decoration: InputDecoration(
                            hintText:'Mot de passe',
                            hintStyle: TextStyle(color: Colors.grey,fontFamily:'Moon'),
                            prefixIcon:Icon(Icons.vpn_key,color: Colors.grey,),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width:30),

                              borderRadius:BorderRadius.circular(60),

                            ),
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.circular(60),
                            ),
                          ),
                          obscureText:true,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){   Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Reset_password();
                        }));},
                        child: Text('Mot de passe oublié\?',
                        style: TextStyle(

                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: 'Lora'


                        ),),
                      ),
                      SizedBox(height: 20.0,),
                      //connecter apres entrer lemail et mod de pass
                      RaisedButton(onPressed:() async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          DataGet.getUserNameByEmail(email)
                              .then((val) async {
                            SnapchatUserInfo=val;
                           await sharingUserInfo.saveuserUserNameSharedprefences(SnapchatUserInfo.documents[0].data["pseudo"]);
                          });
                          sharingUserInfo.saveuserUserEmailSharedprefences(email);
                          sharingUserInfo.saveuserLoggedInSharedprefences(true);


                          dynamic result = await _auth.singIn(email, password);

                          setState(() { loading = false;
                          eroor=result;
                          sharingUserInfo.saveuserLoggedInSharedprefences(false);
                          });

                        };
                      },
                       shape:RoundedRectangleBorder(
                         borderRadius:BorderRadius.circular(60),

                       ) ,
                        padding:EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
                        color:Color(0xffE4E0CA),


                        child: Text('Se connecter',style:TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Lora'),),
                      ),
                      SizedBox(height: 10.0,),
                      Text(eroor, style: TextStyle(color: Colors.red,fontFamily:'Moon'),),
                      SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: ()=>widget.changement(),
                          child:Text('Créer un compte',style:TextStyle(fontWeight: FontWeight.bold,fontFamily: 'lora'),),
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(10),

                        ) ,

                      )
                    ],
                  ),
                ),
              ),
             ),


           ),
         ],
       ),
      ),
    );

  }
}

