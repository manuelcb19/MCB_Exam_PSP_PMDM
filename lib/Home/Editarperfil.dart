import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/FirebaseObjects/FbUsuario.dart';
import 'package:examenmcb/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Editarperfil extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Editarperfil> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late FbUsuario usuario;
  DataHolder conexion = DataHolder();
  String userId = " ";
  String nombre = " ";
  int edad = 0;
  String imagen = " ";
  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");

  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }

  Future<void> cargarUsuario() async {
    usuario = await conexion.fbadmin.conseguirUsuario();
    print("-----------------------------------------");
    print(usuario.shint.toString());
    print(usuario.nombre.toString());
    print(usuario.edad.toString());
    setState(() {});
  }

  Future<void> updateImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  Future<void> updateImageCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  Future<String> setearUrlImagen() async {
    final storageRef = FirebaseStorage.instance.ref();
    print("la ruta guardada en el usuario es: " + usuario.shint.toString());

    String rutaEnNube =
        "usuarios/" + FirebaseAuth.instance.currentUser!.uid + "/imgs/" +
            DateTime
                .now()
                .millisecondsSinceEpoch
                .toString() + ".jpg";
    print("RUTA DONDE VA A GUARDARSE LA IMAGEN: " + rutaEnNube);

    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview, metadata);

      print("SE HA SUBIDO LA IMAGEN");

      // Obtén la URL de la imagen después de subirla
      String url = await rutaAFicheroEnNube.getDownloadURL();
      print("URL de la imagen: $url");
      return url;
    } on FirebaseException catch (e) {
      print("ERROR AL SUBIR IMAGEN: " + e.toString());
      print("STACK TRACE: " + e.stackTrace.toString());
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DataHolder().sNombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (imagen != " ")
              InkWell(
                child: Image.network(
                  imagen,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            SizedBox(height: 20),
            Text("Nombre: " + nombre, style: TextStyle(fontSize: 20)),
            Text("Edad: " + edad.toString(), style: TextStyle(fontSize: 18)),
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
                            decoration: InputDecoration(
                                labelText: 'Nuevo Nombre'),
                          ),
                          TextField(
                            onChanged: (value) {
                              edad = int.tryParse(value) ?? 0;
                            },
                            decoration: InputDecoration(
                                labelText: 'Nueva Edad'),
                          ),
                          TextField(
                            onChanged: (value) {
                              imagen = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Nuevo Otro Dato'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Permite al usuario seleccionar una imagen desde la galería
                              await updateImage();
                            },
                            child: Text('Seleccionar Imagen desde Galería'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Permite al usuario seleccionar una imagen desde la cámara
                              await updateImageCamera();
                            },
                            child: Text('Tomar Foto'),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            // Cerrar el cuadro de diálogo y actualizar los datos en Firestore
                            Navigator.of(context).pop();
                            if (_imagePreview.existsSync()) {
                              imagen = await setearUrlImagen();
                            }
                            conexion.fbadmin.updateUserData(
                                nombre, edad, imagen);
                            setState(() {});
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