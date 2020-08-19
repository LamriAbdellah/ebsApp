
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
          shrinkWrap: true,
           

            itemCount: snapshot.data.documents.length,
            itemBuilder:(context,index){
return MessageTile(message:snapshot.data.documents[index].data["message"],
    IsSendByMe:snapshot.data.documents[index].data["SendBy"]==Constants.Name
);

            }
        ) : Container(
          child:Text("pas de messages"),
        );


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

      extendBodyBehindAppBar:true,
      appBar: AppBar(

        backgroundColor: Color(0xff1E3F63),
        title: Text("Discussion"),
        actions: <Widget>[
          
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: GestureDetector(
        onTap:()=>FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Color(0xffFCFAF1),
                  Color(0xffFCFAF1),

                ]),


          ),
          child: Stack(
            children: <Widget>[

              messagesBuilder(),

              Container(

                  alignment: Alignment.bottomCenter,
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      color: Color(0xff1E3F63),

                      child: Row(

                        children: <Widget>[
                          Flexible(

                              child: Container(

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 4, 8, 4),
                              child: TextField(

                                controller: messageControler,
                                textAlign:TextAlign.center,
                                decoration: InputDecoration(
                                 fillColor:Color(0xffFAF8F2),
                                    filled: true,
                                    hintText:"Aa",
                                  hintStyle:TextStyle(color:Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:BorderRadius.circular(80),
                                  ),
                                  border: OutlineInputBorder(borderRadius:BorderRadius.circular(80),),
                                ),
                              ),
                            ),
                          )

                          ),

                          IconButton(icon: (Icon(Icons.attach_file)),
                            onPressed: () {},
                          ),
                          Container(
                            child: FloatingActionButton(
mini: true,
                                backgroundColor: Colors.grey,
                                onPressed: () {SendMessage();},
                                child: (Icon(Icons.send)
                                )
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),


            ],
          ),
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
        padding: EdgeInsets.only(left:IsSendByMe ? 60:10,right:IsSendByMe ? 10:60),
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
            gradient: LinearGradient(colors: IsSendByMe ?[Colors.grey[350],Colors.grey[350]] :[ Color(0xffBBD0D0),Color(0xffBBD0D0)] ),
          ),
          child: Text(message
          ,style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),),
        ),
      );


  }
}













