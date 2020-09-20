import 'dart:math';
import 'package:epsapp/chat/VideCalls/call.dart';
import 'package:epsapp/chat/VideCalls/call_screen.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/CallServices.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({UserVideoCall from, UserVideoCall to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.pseudo,
      callerPic: from.imageUrl,
      receiverId: to.uid,
      receiverName: to.pseudo,
      receiverPic: to.imageUrl,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => null//CallScreen(call: call),
          ));
    }

  }
}