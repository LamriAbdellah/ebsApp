
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
class messagescreen extends StatefulWidget {
  final String ChatRoomId;

  const messagescreen({Key key, this.ChatRoomId}) : super(key: key);
  @override
  _messagescreenState createState() => _messagescreenState();
}

class _messagescreenState extends State<messagescreen> {

  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
  TextEditingController messageControler = TextEditingController();
  Stream chatroomStream;

  Widget messagesBuilder(){
    return StreamBuilder(
      stream: chatroomStream,
      builder: (context,snapshot){
        return  snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder:(context,index){
return MessageTile(message:snapshot.data.documents[index].data["message"],
    IsSendByMe:snapshot.data.documents[index].data["SendBy"]==Constants.Name
);

            }
        ) : Container();


      },
    );

  }





  //fonction pour enter le message dans la base de donne
  SendMessage() {
    if (messageControler.text.isNotEmpty) {
      Map<String,dynamic> MessageMap = {
        "message": messageControler.text,
        "SendBy": Constants.Name,
        "time":DateTime.now().millisecondsSinceEpoch,

      };

      databaseChatRoom.addChatRoomMessages(widget.ChatRoomId, MessageMap);
      messageControler.text="";
    }
  }
@override
  void initState() {
databaseChatRoom.getChatRoomMessages(widget.ChatRoomId)
.then((value){
  setState(() {
    chatroomStream=value;
  });
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: <Widget>[
            messagesBuilder(),
            Container(

                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: Colors.grey[400],
                    child: Row(

                      children: <Widget>[
                        Flexible(child: Container(
                          color: Colors.grey[400],
                          child: TextField(
                            controller: messageControler,
                            decoration: InputDecoration.collapsed(hintText:"write a message"),
                          ),
                        )),
                        IconButton(icon: (Icon(Icons.attach_file)),
                          onPressed: () {},
                        ),
                        FloatingActionButton(
                            mini: true,
                            onPressed: () {SendMessage();},
                            child: (Icon(Icons.send)
                            )),

                      ],
                    ),
                  ),
                )
            ),


          ],
        ),
      ),
    );
  }
}



class MessageTile  extends StatelessWidget {
  final String message;
  final bool IsSendByMe;

  const MessageTile({Key key, this.message, this.IsSendByMe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left:IsSendByMe ? 0:24,right:IsSendByMe ? 24:0),
margin: EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        alignment: IsSendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          decoration: BoxDecoration(
          borderRadius: IsSendByMe ? BorderRadius.only(
            topLeft: Radius.circular(23),topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
          ):
              BorderRadius.only(
              topLeft: Radius.circular(23),topRight: Radius.circular(23),
            bottomRight: Radius.circular(23)
        ),
            gradient: LinearGradient(colors: IsSendByMe ?[Colors.grey,Colors.grey[500]] :[Colors.blueAccent, Colors.blue] ),
          ),
          child: Text(message
          ,style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),),
        ),
      );


  }
}













