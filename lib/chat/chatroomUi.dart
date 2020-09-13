import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/home/Avatarimage.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';

class ChatRoomUi extends StatefulWidget {
  final String UserName;
  final String ChatRoomId;
  final String ImageUrl;

  const ChatRoomUi({Key key, this.UserName, this.ChatRoomId, this.ImageUrl}) : super(key: key);

  @override
  _ChatRoomUiState createState() => _ChatRoomUiState();
}

class _ChatRoomUiState extends State<ChatRoomUi> {
  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
  Stream chatroomStream;

  @override
  void initState() {
    databaseChatRoom.getLastMessage(widget.ChatRoomId,widget.UserName)
        .then((value){
      setState(() {
        chatroomStream=value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    int color=400;
    return StreamBuilder(
        stream: chatroomStream,
        builder: (context, snapshot) {
          bool isSeen = (snapshot.hasData) ? snapshot.data.documents[snapshot.data.documents.length-1].data["isSeen"] : false;

          return (snapshot.hasData) ? GestureDetector(

            onTap: (){

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          messagescreen(ChatRoomId: widget.ChatRoomId,)));

            },

              child: Container(
                margin: EdgeInsets.only(top: 5,bottom: 5,right: 10),
                padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                decoration: BoxDecoration(
                  color: isSeen   ? Colors.white  : Colors.blue[400] ,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AvatarChat(AvatarUrl:widget.ImageUrl),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${widget.UserName}",
                            style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,),),
                            SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              child: Text("${snapshot.data.documents[snapshot.data.documents.length-1].data["message"]}",
                              style: TextStyle(
                                color: Colors.blueGrey,fontWeight: isSeen  ? FontWeight.w600 : FontWeight.bold  ,
                              ),
                              overflow: TextOverflow.ellipsis,),
                            )
                          ],
                        ),

                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("${snapshot.data.documents[snapshot.data.documents.length-1].data["time/h/m"]}")
                      ],
                    ),
                  ],
                ),
              ),

          ) : GestureDetector(
            onTap: (){

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          messagescreen(ChatRoomId: widget.ChatRoomId,)));

            },
            child: Container(
              margin: EdgeInsets.only(top: 5,bottom: 5,right: 10),
              padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white ,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AvatarChat(AvatarUrl:widget.ImageUrl),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${widget.UserName}",
                            style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,),),
                          SizedBox(height: 5.0,),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}