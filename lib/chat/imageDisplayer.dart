import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class imageDisplayer extends StatefulWidget {
  final String link;
  final bool IsSendByMe;

  const imageDisplayer({Key key, this.link, this.IsSendByMe}) : super(key: key);
  @override
  _imageDisplayerState createState() => _imageDisplayerState();
}

class _imageDisplayerState extends State<imageDisplayer> {
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: widget.IsSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.all(6),
      child: GestureDetector(
        onTap: (){
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>null
                   ));


        },
        child:Material(
        child: CachedNetworkImage(
        placeholder: (context, url) => Container(
        child: CircularProgressIndicator(
        valueColor:
        AlwaysStoppedAnimation<Color>(Colors.black87),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
        Radius.circular(8.0),
        ),
        ),
        ),
    imageUrl:widget.link,
    width:200.0,
    height:200.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    clipBehavior: Clip.hardEdge,
    ),
      ),
    );
  }
}

