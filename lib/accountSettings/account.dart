import 'package:epsapp/accountSettings/AvatarImage.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/screens/ResetPassword.dart';
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
            backgroundColor: Color(0xffFCFAF1),
            appBar: AppBar(
              backgroundColor:Color(0xff1E3F63),
              title: Text("Mon profil",style:TextStyle(fontFamily: 'Lora',)),

            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
              child:


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      Center(
                        child: Avatar(AvatarUrl: user.imageUrl,),
                      ),
                      Divider(

                        color: Colors.grey[600],
                        thickness: 8,
                        height: 60.0,
                      ),
                      Text(

                        'NOM D\'UTILISATEUR',
                        style: TextStyle(
                          color: Colors.grey[600],
                          letterSpacing: 2.0,
                            fontFamily: 'Lora',
                            fontWeight: FontWeight.bold
                        ),

                      ),
                      SizedBox(height: 10.0),
                      Text(
                        user.pseudo,
                        style: TextStyle(
                          color: Color(0xff077893),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Moon'
                        ),
                      ),

                      SizedBox(height: 50.0,),
                      Text(
                        'ADRESSE E-MAIL',
                        style: TextStyle(
                          color: Colors.grey[600],
                          letterSpacing: 2.0,
                            fontFamily: 'Lora',fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Color(0xff077893),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          letterSpacing: 0.5,
                          fontFamily: 'Moon'
                        ),
                      ),

                      SizedBox(height: 60.0,),
                      Center(
                        child: FlatButton.icon(onPressed: () {
                          widget.changement();
                        },
                          icon: Icon(Icons.edit),
                          label: Text("Je change mes informations",style:TextStyle(fontFamily: 'Lora',fontWeight: FontWeight.bold)),
                          color: Color(0xffE4E0CA),
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(60),

                          ) ,),

                      ),
                      SizedBox(height: 5.0,),
                      Center(
                        child: FlatButton.icon(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Reset_password();
                          }));

                        }
                        ,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(60),

                          ) ,
                          icon: Icon(Icons.settings),
                          label: Text("Je modifié mon mot de passe",style:TextStyle(fontFamily: 'Lora',fontWeight: FontWeight.bold)),
                          color: Colors.grey[300],),
                      ),
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
