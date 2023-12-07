
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenmcb/FirebaseObjects/FbPostId.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../FirebaseObjects/FbUsuario.dart';


class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FbUsuario? usuario;

  //String uid = FirebaseAuth.instance.currentUser!.uid;


  //String conseguiruid(){

  //return uid;
  //}

  Future<FbUsuario?> loadFbUsuario() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference<FbUsuario> ref = db.collection("Usuarios")
        .doc(uid)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
      toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);


    DocumentSnapshot<FbUsuario> docSnap = await ref.get();
    usuario = docSnap.data();
    return usuario;
  }


  Future<void> updateUserPost(String Titulo, int post, String imagen) async {


  }


  Future<void> anadirUsuario(String nombre, int edad, String img) async {
    FbUsuario usuario = new FbUsuario(nombre: nombre, edad: edad, shint: img);
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());
  }

  Future<bool> existenDatos() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> datos = await
    db.collection("Usuarios").doc(uid).get();

    if (datos.exists) {
      return true;
    }
    else {
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

  Future<void> updateUserData(String nombre, int edad, String imagen) async {
    FbUsuario usuario = FbUsuario(nombre: nombre, edad: edad, shint: imagen);
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());
  }

  Future<void> updatePostData(String titulo, String postContenido, String imagenUrl, String nombre, String postId) async {


    print("ffffffffffffffffffffffffffffffffffff" + postId);
    DocumentReference<Map<String, dynamic>> postRef = db.collection("PostUsuario").doc(postId);
    // Obtener el documento actual
    DocumentSnapshot<Map<String, dynamic>> postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      // Crear un mapa con los datos actualizados del post
      Map<String, dynamic> postData = {
        'sUrlImg': imagenUrl,
        'Usuario': nombre,
        'Titulo': titulo,
        'Post': postContenido,
        'Idpost' : postId,
        // Agrega aquí otros campos si los tienes
      };

      // Actualizar el documento del post en la colección principal
      await postRef.update(postData);
    } else {
      print("No se encontró el documento con el ID proporcionado.");
      print(postId.toString());
      // Manejar el caso en el que no se encuentra el documento, como mostrar un mensaje al usuario o realizar otra acción.
    }
  }
  Future<String?> getPostReferenceByImagen(String codigoReferenciaImagen) async {
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

    // Realizar una consulta para obtener el post específico por el código de referencia de la imagen
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("PostUsuario")
        .where('sUrlImg', isEqualTo: codigoReferenciaImagen)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Obtener el ID del primer documento en la consulta
      String postId = querySnapshot.docs.first.id;

      // Retornar el ID del post
      return postId;
    }

    // Si no se encuentra ningún documento, retornar null
    return null;
  }
}