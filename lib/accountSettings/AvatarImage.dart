import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  final AvatarUrl;
  final Function Ontap;

  const Avatar({Key key, this.AvatarUrl, this.Ontap}) ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:Ontap,
      child:
      AvatarUrl == null ? CircleAvatar(
        radius: 50.0,
        child:Icon(Icons.camera),

      ):CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(AvatarUrl),

      ),
    );;
  }
}
