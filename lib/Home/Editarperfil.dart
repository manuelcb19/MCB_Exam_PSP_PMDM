import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/FirebaseObjects/FbUsuario.dart';
import 'package:examenmcb/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Editarperfil extends StatefulWidget {



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Editarperfil> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late FbUsuario usuario;
  String userId = " ";
  String nombre = " ";
  int edad = 0;
  String imagen = " ";
  DataHolder conexion = DataHolder();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text((DataHolder().sNombre)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("nombre: "+nombre),
            Text("edad:"+ edad.toString()),
            Text("sHint"+ imagen),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mostrar un cuadro de diálogo para que el usuario ingrese nuevos datos
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Modificar Datos'),
                      content: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              nombre = value;
                            },
                            decoration: InputDecoration(labelText: 'Nuevo Nombre'),
                          ),
                          TextField(
                            onChanged: (value) {
                              edad = int.tryParse(value) ?? 0;
                            },
                            decoration: InputDecoration(labelText: 'Nueva Edad'),
                          ),
                          TextField(
                            onChanged: (value) {
                              imagen = value;
                            },
                            decoration: InputDecoration(labelText: 'Nuevo Otro Dato'),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            // Cerrar el cuadro de diálogo y actualizar los datos en Firestore
                            Navigator.of(context).pop();conexion.fbadmin.updateUserData(nombre,edad,imagen);setState(() {});
                          },
                          child: Text('Guardar Cambios'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Modificar Datos'),
            ),
          ],
        ),
      ),
    );
  }
}