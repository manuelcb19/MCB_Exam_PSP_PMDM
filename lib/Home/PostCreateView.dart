
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:examenmcb/FirebaseObjects/FbUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../CustomViews/CustomTextField.dart';
import '../FirebaseObjects/FbPostId.dart';
import '../Singletone/DataHolder.dart';
import 'package:image_picker/image_picker.dart';




class PostCreateView extends StatefulWidget{
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo=TextEditingController();
  TextEditingController tecPost=TextEditingController();
  late FbUsuario usuario;
  DataHolder conexion= DataHolder();
  ImagePicker _picker = ImagePicker();
  File _imagePreview=File("");

  String imgUrl="";

 @override
  void initState() {
    super.initState();
    //conseguirUsuario();
  }

  void onGalleyClicked() async{

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
        print(_imagePreview.toString());
      });
    }
}

void onCameraClicked() async{

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
    }
 }

  void conseguirUsuario() async {

    usuario = await conexion.fbadmin.conseguirUsuario();

  }

  void subirPost() async {

    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube=
        "posts/"+FirebaseAuth.instance.currentUser!.uid+"/imgs/"+DateTime.now().millisecondsSinceEpoch.toString()+".jpg";
    print("la imagen se ha guardado en: "+rutaEnNube);

    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview,metadata);

    } on FirebaseException catch (e) {
      print("ERROR AL SUBIR IMAGEN: "+e.toString());
    }

    String imgUrl=await rutaAFicheroEnNube.getDownloadURL();

    FbPostId postNuevo=new FbPostId(post: tecPost.text, usuario: usuario.nombre, titulo: tecTitulo.text, sUrlImg: imgUrl, id: " ");

    conexion.insertPostEnFBId(postNuevo);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child:  customTextField(contenido: "introduzca el titulo del post", tecUsername: tecTitulo,oscuro: false,),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: customTextField(contenido: "introduzca el posts", tecUsername: tecPost,oscuro: false,),
          ),

          TextButton(onPressed: onGalleyClicked, child: Text("CargarImagen"),),
          TextButton(onPressed: onCameraClicked, child: Text("selecionar imagen camara"),),
          TextButton(onPressed: subirPost, child: Text("Camara")),
          TextButton(onPressed: () {
            Image.file(_imagePreview,width: 400,height: 400,);
            Row(
            children: [
            TextButton(onPressed: onGalleyClicked, child: Text("Galeria")),
            TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
            );
          }, child: Text("")),
        ],
      ),
    );
  }
}