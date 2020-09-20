import 'package:epsapp/chat/VideCalls/call.dart';
import 'package:epsapp/chat/VideCalls/call_screen.dart';
import 'package:epsapp/services/CallServices.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class RespondScreen extends StatelessWidget {
    Call call;
    CallMethods callMethods = CallMethods();
    RespondScreen({
      @required this.call,
    });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
         /*   CachedImage(
              call.callerPic,
              isRound: true,
              radius: 180,
            ),

          */
            SizedBox(height: 15),
            Text(
              call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  onPressed:() async {
                    await _handleCameraAndMic();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  null//CallScreen(call: call),
                      ),
                    )
                    ;
                  }
    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> _handleCameraAndMic() async {
  await PermissionHandler().requestPermissions(
    [PermissionGroup.camera, PermissionGroup.microphone],
  );
}
