import 'package:epsapp/chat/FullPicture.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class imageDisplayer extends StatefulWidget {
  final String link;
  final bool IsSendByMe;
  final String PictureId;
  final String ChatRoomId;

  const imageDisplayer({Key key, this.link, this.IsSendByMe, this.PictureId, this.ChatRoomId}) : super(key: key);
  @override
  _imageDisplayerState createState() => _imageDisplayerState();
}

class _imageDisplayerState extends State<imageDisplayer> {
  bool isPressed=false;
  @override

  Widget build(BuildContext context) {

    return Container(
      alignment: widget.IsSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.all(6),
      child: GestureDetector(
        onLongPress: (){
          setState(() {
            isPressed=true;
          });
        },
        onTap: (){
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>FullPicture(link: widget.link,)
                   ));




        },
        child:Row(
          mainAxisAlignment:widget.IsSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(6),
              child: Image.network(widget.link),
            ),
            Container(
              padding: EdgeInsets.all(6),
              child: isPressed ? IconButton(icon: Icon(Icons.delete),onPressed: (){
                DatabaseChatRoom().DeleteChatRoomPictures(widget.ChatRoomId, widget.PictureId);
              },):Container(),
            ),
          ],
        ),
      ),
    );
  }
}

