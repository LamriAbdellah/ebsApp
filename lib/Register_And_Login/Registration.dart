import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/guide/MainGuideScreen.dart';
import 'package:epsapp/home/chatpage.dart';
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
  String imageUrl="https://firebasestorage.googleapis.com/v0/b/eps-app-58971.appspot.com/o/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png?alt=media&token=b2c79a4d-2929-45f2-bcd6-cf5d35d86ce0";


  //variable de firebaseauthen
  final  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
     
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
            Text("S\'inscrire",
              style: TextStyle(
                fontSize:28.0,
                fontWeight: FontWeight.bold,
                  fontFamily: 'Lora'
              ),
            ),

            SizedBox(height:50,),
            Expanded(


              child: Container(
                decoration: BoxDecoration(

                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Color(0xffFCFAF1),
                          Color(0xffFCFAF1),

                        ]),
                    borderRadius: BorderRadius.only(topLeft: Radius.elliptical(200,100), topRight: Radius.elliptical(200,100),bottomLeft:Radius.elliptical(200,100),bottomRight:Radius.elliptical(200,100)),

                ),

                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                          child: TextFormField(validator: (val)=> val.isEmpty ? 'Entrez un nom d\'utlisateur' :null,
                            decoration: InputDecoration(
                              prefixIcon:Icon(Icons.supervised_user_circle,color:Colors.grey,),
                              hintText:"Nom d\'utilisateur",
                              hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Moon'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 30,),
                                borderRadius:BorderRadius.circular(60),
                              ),
                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(60
                              ),

                              ),

                            ),

                            onChanged: (val) {  setState(()=>pseudo=val);

                            },
                          ),

                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                          child: TextFormField(
                              validator: (val)=> val.isEmpty ? 'Enterez une adresse e-mail' :null,
                            onChanged: (val) {  setState(()=>email=val);
                            },
                            decoration: InputDecoration(

                              prefixIcon:Icon(Icons.email,color:Colors.grey,),
                              hintText:"Adresse e-mail",
                              hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Moon'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 30,),
                                borderRadius:BorderRadius.circular(60),
                              ),
                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(60),),
                            ),

                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                          child: TextFormField(
                            validator: (val)=> val.isEmpty ? 'Enterez un mot de passe' :null,
                            onChanged: (val) {
                              setState(()=>password=val);
                            },
                            decoration: InputDecoration(

                              prefixIcon:Icon(Icons.lock,color:Colors.grey,),
                              hintText:"Mot de passe",
                              hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Moon'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 30,),
                                borderRadius:BorderRadius.circular(60),
                              ),
                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(60),),
                            ),
                            obscureText:true,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(

                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                          child: TextFormField(
                            validator: (val){  if(val.isEmpty)
    return 'Veulliez confirmer le mot de passe';
    if(val != password)
    return ' passwords doesnt match';
    return null;},

    onChanged: (val) {
                              setState(()=>repassword=val);
                            },
                            decoration: InputDecoration(
                              hintText:"Confirmation mot de passe",
                              hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Moon'),
                              prefixIcon:Icon(Icons.lock,color:Colors.grey,),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white,width: 30,),
                                borderRadius:BorderRadius.circular(60),
                              ),
                              border: OutlineInputBorder(borderRadius:BorderRadius.circular(60),),
                            ),
                            obscureText:true,
                          ),
                        ),

                        SizedBox(height: 15.0,),
                        RaisedButton(onPressed:() async {
                          if (_formKey.currentState.validate()){

                            setState(() {
                              loading = true;});
                          await sharingUserInfo.saveuserStateSharedprefences("new");
                          await sharingUserInfo.saveuserLoggedInSharedprefences(true);
                            await  sharingUserInfo.saveuserUserNameSharedprefences(pseudo);
                            await sharingUserInfo.saveuserUserEmailSharedprefences(email);
                            dynamic result =await _auth.register(email,password,pseudo,1,1,1,1,1,1,imageUrl);

                      //problem de connection ou email forme incorrect
                           setState(() { loading = false;
                           Constants.UserState="";
                        eroor=result;
                        });
                        };
                        },
                          padding:EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                          color:Color(0xffE4E0CA),
                          child: Text('S\'inscrire',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'lora'),),
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(10),

                          ) ,
                        ),
                        SizedBox(height: 5.0,),
                        Text(eroor, style: TextStyle(color: Colors.red),),

                    RaisedButton(
                      onPressed: ()=>widget.changement(),
                      child:Text('Se connecter',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'lora'),),
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10),

                      )) ,
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