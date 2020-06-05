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

  UserData(this.uid, this.pseudo, this.algo,this.analyse,this.algebre,this.elect,this.mecanq,this.poo);
 dynamic getProp(String key) => <String, dynamic>{
  'Algo' : algo,
  'Analyse':analyse,
  'Algebre':algebre,
  'Electronique':elect,
  'Mecanique':mecanq,
  'POO':poo,
 }[key];

}