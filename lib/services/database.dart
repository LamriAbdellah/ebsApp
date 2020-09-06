import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/Constances/selected_module.dart';
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/Constances/constants.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference students = Firestore.instance.collection("students");
  //avoir la liste des etudients qui ont un niv > sup que lutilisateur
  final Query studentsSearch =  Firestore.instance.collection("students").where(selectedModule.selected_module.toLowerCase(),isGreaterThan:Constants.Module_level);
  Future updateUserData (String pseudo,String email,int algo,int analyse,int algebre,int elect,int mecanq,int poo, String imageUrl) async{
    int number;
    await students.where("pseudo",isEqualTo: pseudo).getDocuments().then((value){
      number=value.documents.length;
    });

    return await students.document(uid).setData({
      'uid':uid,
      'pseudo' : pseudo,
      'algo':algo,
      'analyse':analyse,
      'algebre':algebre,
      'elect':elect,
      'mecanq':mecanq,
      'poo':poo,
      'email':email,
      'imageUrl':imageUrl,
    }
    );
  }
//get the students list in the firebase
  List<student> _studentsfromdatabase(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return student( doc.data['pseudo']?? '' ,false,doc.data['algo'] ?? 0
          ,doc.data['analyse'] ?? 0,doc.data['algebre'] ?? 0,doc.data['elect'] ?? 0,doc.data['mecanq'] ?? 0
          ,doc.data['poo'] ?? 0);

    }).toList();
  }
//turning docuemnts to userdata
  UserData _userDatafromSnapchat(DocumentSnapshot snapshot){
    return UserData(
        uid,snapshot.data['pseudo'],snapshot.data['algo'],snapshot.data['analyse'],snapshot.data['algebre'],snapshot.data['elect'],
        snapshot.data['mecanq'],snapshot.data['poo'],snapshot.data['email'],snapshot.data['imageUrl']
    );

  }
//stream for getting studients
  Stream<List<student>> get Students {
    return studentsSearch.snapshots()
        .map(_studentsfromdatabase);
  }

//stream to get the current user data

  Stream<UserData> get user {
    return students.document(uid).snapshots()
        .map(_userDatafromSnapchat);
  }

}
class DatabaseChatRoom{
  //cree la collection des chatroom et ajouter un chat room chaque fois
  createChatRoom(String ChatRoomId,ChatRoomMap){
    Firestore.instance.collection("chatrooms").document(ChatRoomId).setData(ChatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  addChatRoomMessages(String ChatRoomId,MessageMap) {
    Firestore.instance.collection("chatrooms").document(ChatRoomId).collection("chats").add(MessageMap);

  }
  getChatRoomMessages(String ChatRoomId) async {
    return await Firestore.instance.collection("chatrooms").document(ChatRoomId).collection("chats").orderBy("time",descending: false)
        .snapshots();

  }
  getChatRooms(String UserName) async{
    return await Firestore.instance.collection("chatrooms").where("users",arrayContains: UserName)
        .snapshots();
  }
  getLastMessage(String ChatroomId,String UserName) async{
    return await Firestore.instance.collection("chatrooms").document(ChatroomId).collection("chats").where("SendBy",isEqualTo: UserName).orderBy("time",descending: false)
        .snapshots();
  }
  MakeMessagesAsSeen (String message,String ChatroomId,String SendBy) async{
    return await Firestore.instance.collection("chatrooms").document(ChatroomId).collection("chats").where("SendBy",isEqualTo: SendBy).where("message",isEqualTo: message)
        .getDocuments().then((value){
       Firestore.instance.collection("chatrooms").document(ChatroomId).collection("chats")
           .document( value.documents[0].documentID).updateData({
         "isSeen":true,
       });
    });
        
  }
  UpdateChatRoomId(String oldName,String NewName) async{
  await Firestore.instance.collection("chatrooms")
    .where("users",arrayContains:oldName).getDocuments()
        .then((value){

      var newChatRoomId=value.documents[0].data["chatroomid"]
          .replaceAll(oldName,NewName).toString();
      Firestore.instance.collection("chatrooms").document(value.documents[0].documentID).updateData({
        "chatroomid":newChatRoomId,
      });

      /* String oldId=chatroomsWithName.documents[0].data["chatroomid"];
      chatrooms.document(oldId).get().then((value) async{
        await  chatrooms.document(oldId+NewName).setData(value.data);
      });

      */


    });

  }
}
class DatabaseFonctions {
// fonction utiliser pour recuprer le psuedo de lutilisateur par son email
  getUserNameByEmail (String email) async  {
    return await  Firestore.instance.collection("students").where("email",isEqualTo: email)
        .getDocuments();
  }
  getUserNameByID (String uid) async{
    return  await Firestore.instance.collection("students").where("uid",isEqualTo: uid)
        .getDocuments();
  }
  // fonction utiliser pour recuprer le psuedo de lutilisateur par son email
  getUserByName (String name) async  {
    return await  Firestore.instance.collection("students").where("pseudo",isEqualTo: name)
        .getDocuments();
  }
  getModulesLevel  ( String Name)  async{
    return  await Firestore.instance.collection("students").where("pseudo",isEqualTo: Name)
        .getDocuments();
  }
  getImageUrl(String Name) async {
    return  await Firestore.instance.collection("students").where("pseudo",isEqualTo: Name)
        .getDocuments();
  }
}
