import 'dart:io';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/chat/VideCalls/call_utilities.dart';
import 'package:epsapp/chat/imageDisplayer.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/services/storage.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
class messagescreen extends StatefulWidget {
  final String ChatRoomId;
final UserVideoCall TheotherUser;
final UserVideoCall currentUser;
  const messagescreen({Key key, this.ChatRoomId, this.TheotherUser, this.currentUser}) : super(key: key);
  @override
  _messagescreenState createState() => _messagescreenState();
}

class _messagescreenState extends State<messagescreen> {

  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
  TextEditingController messageControler = TextEditingController();
  Stream chatroomStream;
  ScrollController listScrollController = ScrollController();
  int type;
  String imageUrl;
  File image;
  StorageService storageService = StorageService();
  String name;
  Widget messagesBuilder(){
    return StreamBuilder(

      stream: chatroomStream,
      builder: (context,snapshot){
        return  snapshot.hasData ?            ListView.builder(
            shrinkWrap: true,
              controller: listScrollController,
              reverse: true,

              itemCount: snapshot.data.documents.length,
              itemBuilder:(context,index){

              if (snapshot.data.documents[index].data["SendBy"]!=Constants.Name){
                DatabaseChatRoom().MakeMessagesAsSeen(snapshot.data.documents[index].data["message"], widget.ChatRoomId, snapshot.data.documents[index].data["SendBy"]);
              }
return snapshot.data.documents[index].data["type"]==0 ? MessageTile(message:snapshot.data.documents[index].data["message"],
    IsSendByMe:snapshot.data.documents[index].data["SendBy"]==Constants.Name,
  time: snapshot.data.documents[index].data["time"].toString(),
) :imageDisplayer(link:snapshot.data.documents[index].data["message"],IsSendByMe:snapshot.data.documents[index].data["SendBy"]==Constants.Name,PictureId:snapshot.data.documents[index].documentID,ChatRoomId: widget.ChatRoomId

  ,);

              }
          )
         : Container(
        );


      },
    );

  }



  //fonction pour enter les messages et les images dans la base de donne
  SendMessage(int type) {
    if (type==0) {
      if (messageControler.text.isNotEmpty) {
        Map<String, dynamic> MessageMap = {
          "message": messageControler.text,
          "SendBy": Constants.Name,
          "time": DateTime
              .now()
              .millisecondsSinceEpoch,
          "time/h/m": DateTime
              .now()
              .hour
              .toString() + ":" + DateTime
              .now()
              .minute
              .toString(),
          "isSeen": false,
"type":0,
          "SendTo":widget.TheotherUser.pseudo,

        };

        databaseChatRoom.addChatRoomMessages(widget.ChatRoomId, MessageMap);
        messageControler.text = "";
      }
    }
    else{if (type==1){
      Map<String, dynamic> MessageMap = {
        "message":imageUrl,
        "SendBy": Constants.Name,
        "time": DateTime
            .now()
            .millisecondsSinceEpoch,
        "time/h/m": DateTime
            .now()
            .hour
            .toString() + ":" + DateTime
            .now()
            .minute
            .toString(),
        "isSeen": false,
        "type":1,
        "SendTo":widget.TheotherUser.pseudo,

      };
      databaseChatRoom.addChatRoomMessages(widget.ChatRoomId, MessageMap);
    }}
  }
@override
  void initState() {
    name=widget.ChatRoomId.replaceAll("_", "").replaceAll(Constants.Name ?? "" , "");
    imageUrl="";
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
leading:IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  return Wrapper();
}));}),

        backgroundColor: Color(0xff1E3F63),
        title: Text("${name}"),
        actions: <Widget>[

          IconButton(icon: Icon(Icons.call),  onPressed: () async {
            await _handleCameraAndMic() ;
            CallUtils.dial(
              from: widget.currentUser,
              to: widget.TheotherUser,
              context: context,
            ) ;
          }
          ),
          IconButton(icon: Icon(Icons.delete), onPressed: () {
            databaseChatRoom.DeleteChatRoom(widget.ChatRoomId);
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Wrapper();
            }));
          }),

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

                          IconButton(icon: (Icon(Icons.photo)),
                            onPressed: () async {
                              image = await ImagePicker.pickImage(source: ImageSource.gallery);
                              imageUrl=await StorageService().UploadPictures(image);
                              SendMessage(1);},

                          ),
                          IconButton(icon: (Icon(Icons.camera_enhance)),
                            onPressed: () async {

                              image = await ImagePicker.pickImage(source: ImageSource.camera);
                              imageUrl=await StorageService().UploadPictures(image);
                              SendMessage(1);},

                          ),
                          Container(
                            child: FloatingActionButton(
mini: true,
                                backgroundColor: Colors.grey,
                                onPressed: () {SendMessage(0);
                                listScrollController.animateTo(0.0,duration: Duration(milliseconds: 300), curve: Curves.easeOut);},
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
  final String time;

  const MessageTile({Key key, this.message, this.IsSendByMe, this.time}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
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
          ),
          Container(
            child:  IsSendByMe ?Container():Text(
              DateFormat('dd MMM kk:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      int.parse(time))),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic),
            ),
            margin: EdgeInsets.only(left: 5.0, top: 2.0, bottom: 5.0),
          ),
        ],
      );


  }
}



Future<void> _handleCameraAndMic() async {
  await PermissionHandler().requestPermissions(
    [PermissionGroup.camera, PermissionGroup.microphone],
  );
}










