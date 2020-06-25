import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
class chatpage extends StatefulWidget {
final String uid;

  const chatpage({Key key, this.uid}) : super(key: key);

  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  QuerySnapshot SnapchatUserInfo;
  final DatabaseFonctions DataGet = DatabaseFonctions();
  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
  Stream Chatrooms;
  @override
  /*
  void initState()  {
    // TODO: implement initState
    databaseChatRoom.getChatRooms(Constants.Name).
    then((value) {setState(() {
      Chatrooms = value;
    });
    });
    super.initState();
  }

   */
  getUserName(String uid) {
    DataGet.getUserNameByID(uid)
        .then((val){
      SnapchatUserInfo=val;
      Constants.Name= SnapchatUserInfo.documents[0].data["pseudo"] ;
    });
  }
  Widget ChatRomsList(){
    databaseChatRoom.getChatRooms(Constants.Name).
    then((value) {setState(() {
      Chatrooms = value;
    });
    });
    return StreamBuilder(
        stream: Chatrooms,
        builder: (context,snapshot) {
          return (snapshot.hasData)&&(Constants.Name!=null) ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return ChatRoomUi(UserName:snapshot.data.documents[index].data["chatroomid"].toString()
                .replaceAll("_", "").replaceAll(Constants.Name ?? "" , ""),ChatRoomId:snapshot.data.documents[index].data["chatroomid"],) ;
              }
          ) : Container();
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return ChatRomsList();
  }
}


class ChatRoomUi extends StatelessWidget {
  final String UserName;
  final String ChatRoomId;
  const ChatRoomUi({Key key, this.UserName, this.ChatRoomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int color=400;

    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                messagescreen(ChatRoomId: ChatRoomId,)));
        color=200;
      },
      child: Container(
color: Colors.grey[color],
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${UserName.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(width: 8,),
            Text("${UserName}"),
          ],
        ),
      ),
    );
  }
}







