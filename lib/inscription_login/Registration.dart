
import 'package:epsapp/ecran_principal.dart';
import 'package:epsapp/src/accueil.dart';
import 'package:flutter/material.dart';

class inscription extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),

      ),
      body: Container(

        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.supervised_user_circle),
                      labelText: ('pseudo'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),

                    ),

                    onChanged: (val) {

                    },
                  ),

                ),

                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    onChanged: (val) {
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.school),
                      labelText:'specialite',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    onChanged: (val) {
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.email),
                      labelText:'E-mail',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    onChanged: (val) {
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.lock),
                      labelText:'password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: TextFormField(
                    onChanged: (val) {
                    },
                    decoration: InputDecoration(

                      prefixIcon:Icon(Icons.lock),
                      labelText:'password confirmation',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),

                SizedBox(height: 10.0,),
                RaisedButton(onPressed:() {Navigator.pop(context, MaterialPageRoute(builder: (context) {
                  return (ecran_principal());

                }));

                Navigator.pop(context, MaterialPageRoute(builder: (context) {
                  return (ecran_principal());

                }));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return (accueil(index: 0,));
                }));},
                  padding:EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                  color:Colors.blue,
                  child: Text('sign in'),
                )
              ],
            ),
          ),


        ),
      ),
    );

  }
}