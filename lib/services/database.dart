import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epsapp/models/studentSearch.dart';
import 'package:epsapp/models/user.dart';




class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference students = Firestore.instance.collection('students');
  Future updateUserData (String pseudo,int algo,int analyse,int algebre,int elect,int mecanq,int poo) async{
return await students.document(uid).setData({
  'pseudo' : pseudo,
'algo':algo,
  'analyse':analyse,
  'algebre':algebre,
  'elect':elect,
  'mecanq':mecanq,
  'poo':poo,
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
        snapshot.data['mecanq'],snapshot.data['poo']
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