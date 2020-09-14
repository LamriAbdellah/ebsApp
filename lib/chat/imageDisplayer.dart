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

    return GestureDetector(
      onTap: (){
     /*   Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                   FullPhoto(url: widget.link,)));

      */
      },
      child: Image.network(widget.link,width: 200.0,
        height: 200.0,alignment: widget.IsSendByMe ? Alignment.centerRight : Alignment.centerLeft,),
    );
  }
}

