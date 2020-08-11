import 'package:flutter/material.dart';
class AvatarChat extends StatelessWidget {
  final AvatarUrl;


  const AvatarChat({Key key, this.AvatarUrl}) ;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 25.0,
        backgroundImage: NetworkImage(AvatarUrl),


    );
  }
}
