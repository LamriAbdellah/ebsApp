import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/accountSettings/accountSettings.dart';
import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/home/recupage.dart';
import 'package:epsapp/home/sendpage.dart';
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:epsapp/home/chatpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../loading.dart';

class accueil extends StatefulWidget {
  final int index;
final String uid;
  const accueil({Key key, this.index, this.uid}) : super(key: key);
  @override
  _accueilState createState() => _accueilState();
}

class _accueilState extends State<accueil> {


  final  AuthService _auth = AuthService();
  void initState(){
    super.initState();
  }


  //les trois pages send received send
  /* int _currentindex;
  final tabs =[chatpage(),
    sendpage(),
    recupage(),
  ];

   */
  //avoir les chatroom en temp reele
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text('eps '),
        actions: <Widget>[IconButton(icon: Icon(Icons.person), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return accountSettings();
          }));

        }),
          IconButton(onPressed: () async {

              dynamic result = await _auth.SingOut();
              if (result==null){Loading();}
            },
              icon: Icon(Icons.power_settings_new),

              color: Colors.redAccent,),
          ],

      ),
      body:Constants.Name!=null ? chatpage(uid: widget.uid,) : SpinKitDoubleBounce(
        color:Colors.black45,
        size: 50.0,
      ),




      floatingActionButton: FloatingActionButton(
        child: Icon(
          //Add Problem
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return new_problm();
          }));
        },
      ),
      //les buttons pour navigation entre les trois pages chat recu send
      /*
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: (index){
          setState(() {
            _currentindex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.chat) ,
            title: Text("Discussions"),


          ),
          BottomNavigationBarItem(icon: Icon(Icons.send),
            title: Text("envoyer"
            ),

          ),

          BottomNavigationBarItem(icon: Icon(Icons.mail),
            title: Text("recu"),
          ),

        ],
      ),
      */
    );
  }
}







//fonction de lui des chatbooks
