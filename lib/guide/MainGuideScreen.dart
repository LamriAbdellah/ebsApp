import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/guide/first.dart';
import 'package:epsapp/guide/foorth.dart';
import 'package:epsapp/guide/second.dart';
import 'package:epsapp/guide/third.dart';
import 'package:epsapp/home/chatpage.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index=0;
  @override
  void initState() {

    super.initState();
  }
  @override

  List<dynamic> Widgets=[First(),Second(),Third(),Foorth()];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide"),
      ),
      body:Widgets[index] ,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Container(
            alignment: Alignment.bottomLeft,
            child: FlatButton.icon(onPressed: (){
              sharingUserInfo.saveuserStateSharedprefences("");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Wrapper();
              }));
            }
            , icon:Icon(Icons.close), label:Text("passer")),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: FlatButton.icon(onPressed: (){
              setState(() {
                index=index+1;
              });
              if(index==3){
                setState(() {
                  Constants.UserState="";

                });
                sharingUserInfo.saveuserStateSharedprefences("");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Wrapper();
                }));
              }
            }, icon:Icon(Icons.navigate_next), label:Text("suivant")),
          ),
        ],
      ),
    );
  }
}
