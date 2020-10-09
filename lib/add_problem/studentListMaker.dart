import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/selected_module.dart';
import 'package:epsapp/add_problem/ProblemMessageSender.dart';
import 'package:epsapp/chat/messagescreen.dart';
import 'package:epsapp/loading.dart';

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
  Stream StudentsSearch;

  StartChatRoom(String User2Name)async{
    UserVideoCall otherUser=  await DatabaseFonctions().getWholeUserByName(User2Name);
    UserVideoCall CurrentUser = await DatabaseFonctions().getWholeUserByName(Constants.Name);

    String chatroomId=getChatRoomId(User2Name,Constants.Name);
    
    List<String> users =[User2Name,Constants.Name];
    Map<String,dynamic> chatroomMap ={
      "users":users,
      "chatroomid":chatroomId,
    };
ChatRoomCreate.createChatRoom(chatroomId,chatroomMap);
    Navigator.push(context,MaterialPageRoute(builder: (context) => messagescreen(ChatRoomId: chatroomId,TheotherUser: otherUser,currentUser: CurrentUser,)));
  }

  @override
  Widget build(BuildContext context) {

    UserData user=Provider.of<UserData>(context);
DatabaseServices().GetStudentsProblems(user.getProp(selectedModule.selected_module)).then((v){
  setState(() {
    StudentsSearch=v;
  });

});
      return  StreamBuilder(
        stream:StudentsSearch,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
                itemCount: snapshot.data.documents.length,
itemBuilder: (context,index)
{
            return  Row(
                children: <Widget>[
                  Card(
                    child: Text(snapshot.data.documents[index].data["pseudo"]),
                  ),
                  Spacer(),
                  
                  GestureDetector(onTap: ()  async {
                    UserVideoCall otherUser=  await DatabaseFonctions().getWholeUserByName(snapshot.data.documents[index].data["pseudo"]);
                    Firestore.instance.collection("students").document(user.uid).updateData({'ChattingWith':otherUser.uid});
                    MessageSender().SendProblem(widget.problem, getChatRoomId(snapshot.data.documents[index].data["pseudo"],Constants.Name),snapshot.data.documents[index].data["pseudo"]);
StartChatRoom(snapshot.data.documents[index].data["pseudo"]);
                  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Icon(Icons.textsms,size:30.0,),

                      ),
                    ),),
Divider(),
                ],

              );



}

                ):Loading();
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