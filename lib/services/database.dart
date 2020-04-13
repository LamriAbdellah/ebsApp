import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/models/user.dart';




class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference students = Firestore.instance.collection('students');
  Future updateUserData (String pseudo,int level) async{
return await students.document(uid).setData({
  'pseudo' : pseudo,
'level':level,
}
);
  }
//get the students list in the firebase
  List<student> _studentsfromdatabase(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return student( doc.data['pseudo']?? '', false ,doc.data['level'] ?? 0);

    }).toList();



  }
//turning docuemnts to userdata
  UserData _userDatafromSnapchat(DocumentSnapshot snapshot){
    return UserData(
      uid,snapshot.data['pseudo'],snapshot.data['level']
    );

  }
//stream for getting studients
Stream<List<student>> get Students {
    return students.snapshots()
        .map(_studentsfromdatabase);
}

//stream to get the current user data

Stream<UserData> get user {
    return students.document(uid).snapshots()
        .map(_userDatafromSnapchat);
}

}