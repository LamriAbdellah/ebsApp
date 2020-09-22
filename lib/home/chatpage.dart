import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/accountSettings/accountSettings.dart';
import 'package:epsapp/add_problem/NewProblem.dart';
import 'package:epsapp/chat/VideCalls/respond_service.dart';
import 'package:epsapp/chat/chatroomUi.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/guide/intro_page.dart';
import 'package:epsapp/guide/splash.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/services/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NavDrawer extends StatelessWidget {

  @override
  final  AuthService _auth = AuthService();
  FirebaseMessaging firebaseMessaging =FirebaseMessaging();

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
              onTap: () {  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return IntroPage(Case: 1,);
              }));},
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
                UserVideoCall User= await DatabaseFonctions().getWholeUserByName(Constants.Name);
                Firestore.instance
                    .collection('students')
                    .document(User.uid)
                    .updateData({'pushToken': ""});
                firebaseMessaging.deleteInstanceID();

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
  FirebaseMessaging firebaseMessaging =FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
 getUsername() async{
    Constants.Name=await sharingUserInfo.getuserNameSharedprefences();
    print(Constants.Name);
  }
  //initlisation des notifications;
  Future<void> registerNotification() async {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      showNotification(message['notification']);

      print("onMessage: $message");
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });
    UserVideoCall User= await DatabaseFonctions().getWholeUserByName(Constants.Name);
    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance
          .collection('students')
          .document(User.uid)
          .updateData({'pushToken': token});
    }).catchError((err) {
    });
  }
  void configLocalNotification() {
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'com.example.ebsapp',
      'ebs app',
      'your ebs app',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }


getUserState() async{
  Constants.UserState=await sharingUserInfo.getuserStateSharedprefences();
}


@override
  void initState() {

  registerNotification();
  configLocalNotification();
getUserState();
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
          getUsername();
          GetStudentList().GetChatRooms();
          return (snapshot.hasData)&&(Constants.Name!=null) ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                var chatroomid = snapshot.data.documents[index].data["chatroomid"].toString();
                var  username=  snapshot.data.documents[index].data["chatroomid"]
                    .replaceAll("_", "").replaceAll(Constants.Name ?? "" , "");

                return ChatRoomUi(UserName:username,ChatRoomId:chatroomid,ImageUrl: imageUrl,) ;
              }
          ) : Container();
        }
    );

  }

  @override
  Widget build(BuildContext context) {
      getUserState();
    return Constants.UserState=="new" ? SplashScreen(): PickupLayout(
      scaffold: Scaffold(

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



