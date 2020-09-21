class User{
  final String uid;
  User(this.uid);

}
class UserData{
 final String uid;
 final String pseudo ;
 final int algo;
 final int analyse;
 final int algebre;
 final int elect;
 final int mecanq;
 final int poo;
final String email;
 final String imageUrl;
 final String pushToken;
 final String ChattingWith;
  UserData(this.uid, this.pseudo, this.algo,this.analyse,this.algebre,this.elect,this.mecanq,this.poo,this.email, this.imageUrl, this.pushToken, this.ChattingWith);
 dynamic getProp(String key) => <String, dynamic>{
  'name':pseudo,
  'Algo' : algo,
  'Analyse':analyse,
  'Algebre':algebre,
  'Electronique':elect,
  'Mecanique':mecanq,
  'POO':poo,
  'email':email,
 }[key];

}
class UserVideoCall{
 final String uid;
 final String pseudo ;
 final String imageUrl;

  UserVideoCall(this.uid, this.pseudo, this.imageUrl);
}