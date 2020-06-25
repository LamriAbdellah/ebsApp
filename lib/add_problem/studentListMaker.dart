
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/add_problem/ProblemMessageSender.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/Constances/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class studentsListMaker extends StatefulWidget {
 var problem;
 studentsListMaker({this.problem});
  @override
  _studentsListMakerState createState() => _studentsListMakerState();
}

class _studentsListMakerState extends State<studentsListMaker> {
  QuerySnapshot SnapchatUserInfo;
  final DatabaseChatRoom ChatRoomCreate =DatabaseChatRoom();
  StartChatRoom(String User2Name){

    String chatroomId=getChatRoomId(User2Name,Constants.Name);
    
    List<String> users =[User2Name,Constants.Name];
    Map<String,dynamic> chatroomMap ={
      "users":users,
      "chatroomid":chatroomId,

    };
ChatRoomCreate.createChatRoom(chatroomId,chatroomMap);
    Navigator.push(context,MaterialPageRoute(builder: (context) => messagescreen(ChatRoomId: chatroomId,)));
  }

 
  @override
  Widget build(BuildContext context) {
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
            return  Row(
                children: <Widget>[
                  Card(
                    child: Text(students[index].name),
                  ),
                  Spacer(),
                  GestureDetector(onTap: () {
                    MessageSender().SendProblem(widget.problem, getChatRoomId(students[index].name,Constants.Name));
StartChatRoom(students[index].name);
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Text("message"),
                      ),
                    ),),

                ],
              );



}


                );
        }
      );



    }
  }

getChatRoomId(String a, String b ){
if (a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
  return "$b\_$a";
}
else {
  return "$a\_$b";
}

}