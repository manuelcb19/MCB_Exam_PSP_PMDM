

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/CustomViews/CustomButton.dart';
import 'package:examenmcb/Singletone/DataHolder.dart';
import 'package:flutter/material.dart';

import '../CustomViews/CustomTextField.dart';

class PerfilView extends StatelessWidget {

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  DataHolder conexion = DataHolder();

  void onClickAceptar() async{

    conexion.fbadmin.anadirUsuario(tecNombre.text, int.parse(tecEdad.text), '');

    Navigator.of(_context).popAndPushNamed("/homeview");
  }


  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          centerTitle: true,
          shadowColor: Colors.orangeAccent,
          backgroundColor: Colors.orangeAccent,
        ),
        backgroundColor: Colors.amber[200],
        body:
        Center(
          child: ConstrainedBox(constraints: BoxConstraints(
            minWidth: 500,
            minHeight: 700,
            maxWidth: 1000,
            maxHeight: 900,
          ),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    child:  customTextField( tecUsername: tecNombre,oscuro: false, sHint: "Introduzca su usuario",)
                ),

                Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                    child:  customTextField( tecUsername: tecEdad, oscuro: false,sHint: "Introduzca su edad",)
                ),

                //Aqui se pedira mas adelante la fotografia, es por eso que en la base de datos aparecera un String vacio por ahora
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                           CustomButton(texto: "aceptar", funcion: onClickAceptar,)

                    ]
                )
              ],
            ),),
        )
    );
  }
}