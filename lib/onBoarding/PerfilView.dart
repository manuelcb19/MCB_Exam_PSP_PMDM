import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/CustomViews/CustomButton.dart';
import 'package:examenmcb/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../CustomViews/CustomTextField.dart';

class PerfilView extends StatefulWidget {
  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  DataHolder conexion = DataHolder();
  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  String imagenPredefinida = "resources/imagenpredefinida.png";
  bool mostrarPredefinida = true; // Variable para controlar la visibilidad de la imagen predefinida

  void onClickAceptar() async {
    setState(() {
      mostrarPredefinida = false; // Después de seleccionar una nueva imagen, ocultar la predefinida
    });

    String imageUrl = await setearUrlImagen();
    print(imageUrl);
    conexion.fbadmin.anadirUsuario(tecNombre.text, int.parse(tecEdad.text), imageUrl);
    Navigator.of(_context).popAndPushNamed("/homeview");
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _imagePreview = File(pickedImage.path);
        mostrarPredefinida = false; // Después de seleccionar una nueva imagen, ocultar la predefinida
      });
    }
  }

  Future<String> setearUrlImagen() async {
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube =
        "posts/" + FirebaseAuth.instance.currentUser!.uid + "/imgs/" +
            DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
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
    this._context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        shadowColor: Colors.orangeAccent,
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.amber[200],
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 500,
            minHeight: 700,
            maxWidth: 1000,
            maxHeight: 900,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mostrar la imagen predefinida y la imagen seleccionada
              Column(
                children: [
                  if (mostrarPredefinida)
                    Image.asset(
                      imagenPredefinida,
                      width: 300,
                      height: 450,
                    ),
                  if (_imagePreview != null && !mostrarPredefinida)
                    Image.file(
                      _imagePreview,
                      height: 200, // Ajusta la altura según tus necesidades
                      width: 200, // Ajusta el ancho según tus necesidades
                      fit: BoxFit.cover,
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                child: customTextField(
                  tecUsername: tecNombre,
                  oscuro: false,
                  sHint: "Introduzca su usuario",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                child: customTextField(
                  tecUsername: tecEdad,
                  oscuro: false,
                  sHint: "Introduzca su edad",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // Permite al usuario seleccionar una imagen desde la galería
                      await _getImage();
                    },
                    child: Text('Seleccionar Imagen desde Galería'),
                  ),
                  CustomButton(texto: "aceptar", onPressed: onClickAceptar),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
