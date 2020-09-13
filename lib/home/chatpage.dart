import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/accountSettings/accountSettings.dart';
import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:epsapp/chat/chatroomUi.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
class NavDrawer extends StatelessWidget {

  @override
  final  AuthService _auth = AuthService();


  Widget build(BuildContext context) {

    return Drawer(

      child: Container(
        color: Color(0xffFCFAF1),
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[


            DrawerHeader(

              decoration: BoxDecoration(
              ),
            ),

            ListTile(

              leading: Icon(Icons.input),
              title: Text('Guide',style: TextStyle(fontFamily: 'Lora'),),
              onTap: () => {},
            ),
            Divider(),
            ListTile(

              leading: Icon(Icons.verified_user),
              title: Text('Mon profil',style: TextStyle(fontFamily: 'Lora'),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return accountSettings();
                }));

              },

            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Se déconnecter',style: TextStyle(fontFamily: 'Lora'),),
              onTap: () async {

                dynamic result = await _auth.SingOut();
                if (result==null){Loading();}
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
class chatpage extends StatefulWidget {
final String uid;

  const chatpage({Key key, this.uid}) : super(key: key);

  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  List<String> students =[];
  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
  Stream Chatrooms;
  String imageUrl="";
 getUsername() async{
    Constants.Name=await sharingUserInfo.getuserNameSharedprefences();
    print(Constants.Name);
  }



@override
  void initState() {
getUsername();
  }

  @override

  Widget ChatRomsList(){

    databaseChatRoom.getChatRooms(Constants.Name).
    then((value) {setState(() {
      Chatrooms = value;

    });
    });
    return StreamBuilder(
        stream: Chatrooms,
        builder: (context,snapshot) {
          GetStudentList().GetChatRooms();
          return (snapshot.hasData)&&(Constants.Name!=null) ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var chatroomid = snapshot.data.documents[index].data["chatroomid"].toString();
                var  username= snapshot.data.documents[index].data["chatroomid"]
                    .replaceAll("_", "").replaceAll(Constants.Name ?? "" , "");


                return ChatRoomUi(UserName:username,ChatRoomId:chatroomid,ImageUrl: imageUrl,) ;
              }
          ) : Container();
        }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        drawer: NavDrawer(),
    backgroundColor: Color(0xffFCFAF1),
    appBar: AppBar(
    backgroundColor:Color(0xff1E3F63),
    actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed:(){

      showSearch(context: context, delegate: DataSearch());})],
    title: Text('EBS ',style: TextStyle(fontFamily: 'Lora',fontSize: 28.0,letterSpacing: 2.0),),
    centerTitle: true,
    ),
    body:       ChatRomsList(),
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
    );
  }
}




class GetStudentList{

  Query snap ;
  GetChatRooms() async{
    var username;
    var chatroomid;
  await Firestore.instance.collection("chatrooms").where("users",arrayContains: Constants.Name)
        .getDocuments()
    .then((value){
      Constants.studentsSearchList.clear();
      Constants.chatroomsearchIds.clear();
      var i;
      for(i=0;i<=value.documents.length;i++) {
        username = value.documents[i].data["chatroomid"]
            .replaceAll("_", "").replaceAll(Constants.Name ?? "", "");
        Constants.studentsSearchList.add(username);
        chatroomid=value.documents[i].data["chatroomid"];
        Constants.chatroomsearchIds.add(chatroomid);
      }
    });
  }
}

class DataSearch extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon:Icon(Icons.clear), onPressed:(){
      query="";
    }),];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon:AnimatedIcons.menu_arrow,
      progress:transitionAnimation ,

    ),
      onPressed:(){
      close(context, null);
      },);
  }

  @override
  Widget buildResults(BuildContext context) {
String ChatRoomId;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                messagescreen(ChatRoomId: ChatRoomId,)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
final StudentsList =
Constants.studentsSearchList.where((string) => string.contains(query)).toList();



return ListView.builder(itemBuilder: (context,index) => ListTile(
  onTap: (){
    buildResults(context);
  },
  title:  ChatRoomUi(UserName:StudentsList[index] ,ChatRoomId:Constants.chatroomsearchIds.where((string) => string.contains(StudentsList[index])).toList()[0],ImageUrl: "",),





),
  itemCount: StudentsList.length,
);

  }



}



