import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/add_problem/problem_class.dart';
import 'package:epsapp/services/database.dart';

class MessageSender{
  DatabaseChatRoom databaseChatRoom = DatabaseChatRoom();
   Problem problem;
  SendProblem(Problem problem,String ChatRoomId) {
    if (problem.desc.isNotEmpty) {
     Map<String,dynamic> ProblemModuleMap = {
        "message":"Module:"+ problem.module,
        "SendBy": Constants.Name,
        "time":DateTime.now().millisecondsSinceEpoch,
       "time/h/m":DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
       "isSeen":false,
       "type":0,

      };

      databaseChatRoom.addChatRoomMessages(ChatRoomId, ProblemModuleMap);

     Map<String,dynamic> ProblemDescMap = {
       "message": "Title:" + problem.desc,
       "SendBy": Constants.Name,
       "time":DateTime.now().millisecondsSinceEpoch,
       "time/h/m":DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
       "isSeen":false,
       "type":0,

     };

     databaseChatRoom.addChatRoomMessages(ChatRoomId, ProblemDescMap);
     Map<String,dynamic> ProblemDetilsMap = {
       "message": problem.details,
       "SendBy": Constants.Name,
       "time":DateTime.now().millisecondsSinceEpoch,
       "time/h/m":DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
       "isSeen":false,
       "type":0,

     };

     databaseChatRoom.addChatRoomMessages(ChatRoomId, ProblemDetilsMap);

    }
  }

}