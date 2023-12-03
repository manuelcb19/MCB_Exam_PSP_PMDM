
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../FirebaseObjects/FbUsuario.dart';


class FirebaseAdmin{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FbUsuario? usuario;
  //String uid = FirebaseAuth.instance.currentUser!.uid;


  //String conseguiruid(){

    //return uid;
  //}

  Future<FbUsuario?> loadFbUsuario() async{

    String uid=FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<FbUsuario> ref=db.collection("Usuarios")
        .doc(uid)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);


    DocumentSnapshot<FbUsuario> docSnap=await ref.get();
    usuario=docSnap.data();
    return usuario;
  }

  Future<void> updateUserData(String nombre, int edad, String imagen) async {

    FbUsuario usuario = FbUsuario(nombre: nombre, edad: edad, shint: imagen);
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());



  }

  Future<void> anadirUsuario(String nombre, int edad, String img) async {

    FbUsuario usuario = new FbUsuario(nombre: nombre, edad: edad, shint: img);
    String uidUsuario= FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

  }

  Future<bool> existenDatos() async {

    String uid=FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> datos = await
    db.collection("Usuarios").doc(uid).get();

    if(datos.exists)
      {
        return true;
      }
    else
      {
        return false;
      }

  }

  Future<FbUsuario> conseguirUsuario() async {


    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);

    DocumentReference<FbUsuario> enlace = db.collection("Usuarios").doc(
        uid).withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);

    FbUsuario usuario;

    DocumentSnapshot<FbUsuario> docSnap = await enlace.get();
    usuario = docSnap.data()!;

    return usuario;

  }
}