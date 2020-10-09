class User{
  final String uid;
  User(this.uid);

}
class UserData{
  String uid;
  String pseudo ;
  int algo;
  int analyse;
  int algebre;
  int elect;
  int mecanq;
  int poo;
String email;
  String imageUrl;
  String pushToken;
  String ChattingWith;
  UserData(this.uid, this.pseudo, this.algo,this.analyse,this.algebre,this.elect,this.mecanq,this.poo,this.email, this.imageUrl, this.pushToken, this.ChattingWith);
 dynamic getProp(String key) => <String, dynamic>{
  'name':pseudo,
  'algo' : algo,
  'analyse':analyse,
  'algebre':algebre,
  'elect':elect,
  'mecanq':mecanq,
  'poo':poo,
  'email':email,
 }[key];

}
class UserVideoCall{
 final String uid;
 final String pseudo ;
 final String imageUrl;

  UserVideoCall(this.uid, this.pseudo, this.imageUrl);
}