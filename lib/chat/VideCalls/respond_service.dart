import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/chat/VideCalls/call.dart';
import 'package:epsapp/chat/VideCalls/respond_screen.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/CallServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();

  PickupLayout({
    @required this.scaffold,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
        return StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(uid: user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.data != null) {
          Call call = Call.fromMap(snapshot.data.data);

          if (!call.hasDialled) {
            return RespondScreen(call: call);
          }
        }
        return scaffold;
      },

    );
  }
}