import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/home/Avatarimage.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/shared_prefrences/sharing_userInfos.dart';
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
  String imageUrl="";
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
                    .replaceAll("_", "").replaceAll(Constants.Name ?? "" , ""),ChatRoomId:snapshot.data.documents[index].data["chatroomid"],ImageUrl: imageUrl,) ;
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
  final String ImageUrl;
  const ChatRoomUi({Key key, this.UserName, this.ChatRoomId, this.ImageUrl}) : super(key: key);

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

      },
      child: Container(
color: Colors.grey[color],
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Row(
          children: <Widget>[
            AvatarChat(AvatarUrl:ImageUrl),
            SizedBox(width: 8,),
            Text("${UserName}"),
          ],
        ),
      ),
    );
  }
}







