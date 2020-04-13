
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class studentsListMaker extends StatefulWidget {
  final int level;

  const studentsListMaker({Key key, this.level}) : super(key: key);
  @override
  _studentsListMakerState createState() => _studentsListMakerState();
}

class _studentsListMakerState extends State<studentsListMaker> {

  @override
  Widget build(BuildContext context) {
int level =widget.level;
    final students = Provider.of<List<student>>(context) ?? [];
final user =Provider.of<User>(context);
      return  StreamBuilder<UserData>(
        stream:DatabaseServices(uid:user.uid).user,
        builder: (context, snapshot) {
          UserData user = snapshot.data;
          return ListView.builder(
                itemCount: students.length,
itemBuilder: (context,index)
{
          if ((students[index].level>=level)&&(students[index].name!=user.pseudo)) {
            return Card(
              child: CheckboxListTile(
                value: students[index].select,
                onChanged: (bool value) {
                  setState(() {
                    students[index].select = value;
                  });
                },
                title: Text(students[index].name),
              ),
            );
          }

}


                );
        }
      );



    }
  }

