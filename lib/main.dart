
import 'package:epsapp/services/auth.dart';
import 'package:epsapp/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

/*
void main() => runApp( app());
    class app extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return        MaterialApp(
          home: chat())  ;
      }
    }

 */
void main() => runApp( app());
class app extends StatelessWidget {
@override
Widget build(BuildContext context) {
return StreamProvider<User>.value(
value:AuthService().user ,
child: MaterialApp(
home: Wrapper(index: 0,),
),
);
}
}








