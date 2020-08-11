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
      backgroundColor:Color(0xffFCFAF1),
      appBar: AppBar(

        backgroundColor: Color(0xff1E3F63),
      ),
      body: Column(

        children: <Widget>[

          SizedBox(height:20),
          Center(
            child: Text("Mot de passe oublié\?",
              style: TextStyle(
              fontSize: 28.0,fontFamily:'Lora',fontWeight: FontWeight.bold),

            ),

          ),
          SizedBox(height: 20,),
          Center(
          child:  Text("Entrez votre adresse e-mail ou le numero de téléphone",style: TextStyle(color:Colors.grey[600],fontFamily: 'Lora',fontSize: 13),),
          ),
          SizedBox(height: 50.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
            child: TextFormField(
              validator: (val)=> val.isEmpty ? 'enter an email' :null,
              decoration: InputDecoration(
                fillColor:Colors.white,
                filled: true,
                prefixIcon:Icon(Icons.email,color:Colors. grey,),
                hintText: ('Adresse e-mail'),
                hintStyle:TextStyle(fontFamily: 'Moon'),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,),
                  borderRadius:BorderRadius.circular(60),
                ),
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(60),),

              ),

              onChanged: (val) {
                setState(()=>email=val);
              },
            ),

          ),
          SizedBox(height: 20,),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              onPressed:(){
               dynamic resetresult= _auth.ResetPassword(email);
               setState(() {

                 eroor="E-mail envoyé";
               });
              },
              child: Text("Continue",style: TextStyle(fontFamily: 'Lora',fontWeight: FontWeight.bold),),
              disabledColor:Colors.grey,
              highlightColor:Color(0xff1E3F63),
              elevation: 8,
              autofocus: true,
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10),

              ) ,

            ),
          ),
        SizedBox(height: 8,),
        Text(eroor.toString(),style:TextStyle(fontFamily: 'Lora',fontWeight: FontWeight.bold),)],
      ),


    );
  }
}
