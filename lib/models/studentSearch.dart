class student {
  String name;
  bool select;
   int algo;
   int analyse;
  int algebre;
  int elect;
   int mecanq;
int poo;

  student(String name,bool select,int algo,
  int analyse,
  int algebre,
  int elect,
  int mecanq,
  int poo,) {
    this.name = name;
    this.select=select;
    this.algo=algo;
    this.analyse=analyse;
    this.elect=elect;
    this.mecanq=mecanq;
    this.poo=poo;


  }
  dynamic getProp(String key) => <String, dynamic>{
    'name':name,
    'Algo' : algo,
    'Analyse':analyse,
    'Algebre':algebre,
    'Electronique':elect,
    'Mecanique':mecanq,
    'POO':poo,
  }[key];

}
