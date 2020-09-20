import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class FullPicture extends StatefulWidget {
  final String link;

  const FullPicture({Key key, this.link}) : super(key: key);
  @override
  _FullPictureState createState() => _FullPictureState();
}

class _FullPictureState extends State<FullPicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(imageProvider: NetworkImage(widget.link)),
    );
  }
}
