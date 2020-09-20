import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
class AvatarChat extends StatefulWidget {
  final AvatarUrl;
final AvatarName;

  const AvatarChat({Key key, this.AvatarUrl, this.AvatarName}) ;

  @override
  _AvatarChatState createState() => _AvatarChatState();
}

class _AvatarChatState extends State<AvatarChat> {
  String ImageUrl;
  //Avoir le lien de photo de profil de lautre utilisateur
  getImageUrl()async{
   ImageUrl=await DatabaseFonctions().getImageUrl(widget.AvatarName);
  }
  @override
  void initState() {
    getImageUrl();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 25.0,
        backgroundImage:ImageUrl!=null ? NetworkImage(ImageUrl):NetworkImage(widget.AvatarUrl),


    );
  }
}
