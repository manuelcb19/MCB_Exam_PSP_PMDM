




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CustomViews/CustomButton.dart';

class HomeView extends StatefulWidget{

  String uid=FirebaseAuth.instance.currentUser!.uid;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Examen"),
        shadowColor: Colors.orangeAccent, // Color de sombra del AppBar
        backgroundColor: Colors.orangeAccent,),
      backgroundColor: Colors.amber[200],// Color de fondo del AppBar
      body: Center(
      ),
      bottomNavigationBar: CustomButton(texto: (FirebaseAuth.instance.currentUser!.uid).toString(),),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      /**/
    );
  }

}