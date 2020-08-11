import 'dart:io';
import 'package:epsapp/Constances/constants.dart';
import 'package:epsapp/accountSettings/AvatarImage.dart';
import 'package:epsapp/loading.dart';
import 'package:epsapp/models/user.dart';
import 'package:epsapp/services/database.dart';
import 'package:epsapp/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
class settings extends StatefulWidget {
  final Function changement;

  const settings({Key key, this.changement}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  int algo=Constants.algo;
  int analyse=Constants.analyse;
  int algebre=Constants.algebre;
  int elect=Constants.elect;
  int mecanq=Constants.mecanq;
  int poo=Constants.poo;
  String pseudo;
  String imageUrl;
  File image;
  StorageService storageService = StorageService();
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid:user.uid).user,
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      UserData user = snapshot.data;

      return Scaffold(
        backgroundColor: Color(0xffFCFAF1),
        appBar: AppBar(
          backgroundColor:Color(0xff1E3F63),


        ),
        body: GestureDetector(
          onTap:()=>FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
            child: Center(child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Avatar(
                        AvatarUrl:user.imageUrl,
                        Ontap: () async {
                          image = await ImagePicker.pickImage(source: ImageSource.gallery);
                          imageUrl=await StorageService().UploadStorage(image);
                          print(imageUrl);



                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10.0),
                      child: TextFormField(
style: TextStyle(fontFamily: 'Moon',fontWeight:FontWeight.bold),
                        initialValue: user.pseudo,
                        validator: (val) =>
                        val.isEmpty ? 'enter a valid name'  : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.supervised_user_circle),
                          labelText: ('Nom d\'utilisateur'),
                          labelStyle: TextStyle(fontFamily: 'Lora',fontSize: 18),
                          enabledBorder: OutlineInputBorder(

                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius:BorderRadius.circular(60),
                          ),
                          border: OutlineInputBorder( borderRadius:BorderRadius.circular(60),),

                        ),

                        onChanged: (val) {
                          setState(() => pseudo = val);
                        },
                      ),

                    ),
                    SizedBox(height: 20.0),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("Algorithme",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            value: (algo ?? 1).toDouble(),
                            label: algo.toString(),
                            inactiveColor: Colors.blueAccent[algo?? 100],
                            activeColor:Colors.blueAccent[algo*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => algo = val.round()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("Analyse",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            value: (analyse ?? 1).toDouble(),
                            label: analyse.toString(),
                            inactiveColor: Colors.blueAccent[analyse?? 100],
                            activeColor:Colors.blueAccent[analyse*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => analyse= val.round()),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("Algèbre",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            label: algebre.toString(),
                            value: ( algebre ?? 1).toDouble(),
                            inactiveColor: Colors.blueAccent[algebre?? 100],
                            activeColor:Colors.blueAccent[algebre*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => algebre = val.round()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("Eléctronique",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            label: elect.toString(),
                            value: (elect ?? 1).toDouble(),
                            inactiveColor: Colors.blueAccent[elect?? 100],
                            activeColor:Colors.blueAccent[elect*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => elect = val.round()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("Mécanqiue",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            label: mecanq.toString(),
                            value: (mecanq ?? 1).toDouble(),
                            inactiveColor: Colors.blueAccent[mecanq ?? 100],
                            activeColor:Colors.blueAccent[mecanq*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => mecanq = val.round()),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: <Widget>[
                          Text("P.O.O",style:TextStyle(fontFamily: 'Lora',)),
                          Slider(
                            label: "$poo",
                            value: (poo ?? 1).toDouble(),
                            inactiveColor: Colors.blueAccent[poo?? 100],
                            activeColor:Colors.blueAccent[poo*100 ?? 100],
                            min: 1.0,
                            max: 5.0,
                            divisions: 4,
                            onChanged: (val) => setState(() => poo = val.round()),
                          ),
                        ],
                      ),
                    ),




                    SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: FlatButton.icon(onPressed: () async {

                          await DatabaseServices(uid:user.uid).updateUserData(pseudo ?? user.pseudo,user.email, algo ?? user.algo,analyse ?? user.analyse,
                              algebre ?? user.algebre,elect ?? user.elect,mecanq ?? user.mecanq,poo ?? user.poo,imageUrl ?? user.imageUrl);


                          widget.changement();
                      },
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(60),

                        ) ,
                          icon: Icon(Icons.save),
                          label: Text("Sauvegarder",style:TextStyle(fontFamily: 'Lora',fontWeight:FontWeight.bold)),
                          color:Color(0xffE4E0CA),),
                    )
                  ],
                ),
              ),
            ),
            ),
          ),
        ),
      );
    }
    else{return Loading();}
      }
    );
  }
}
