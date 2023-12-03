import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirebaseObjects/FbPostId.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';


class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre="Examen";
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbadmin=FirebaseAdmin();
  late FbPostId selectedPost;
  GeolocAdmin geolocAdmin = GeolocAdmin();

  DataHolder._internal() {
  }

  void initDataHolder(){


  }

  factory DataHolder(){
    return _dataHolder;
  }

  void insertPostEnFBId(FbPostId postNuevo){
    CollectionReference<FbPostId> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPostId.fromFirestore,
      toFirestore: (FbPostId post, _) => post.toFirestore(),
    );

    postsRef.add(postNuevo);
  }

  void saveSelectedPostInCache() async{
    if(selectedPost!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('postsusuario_surlimg', selectedPost!.sUrlImg);
      prefs.setString('postsusuario_usuario', selectedPost!.usuario);
      prefs.setString('postsusuario_titulo', selectedPost!.titulo);
      prefs.setString('postsusuario_post', selectedPost!.post);
      prefs.setString('postsusuario_IdUsuario', selectedPost!.id);

    }

  }


}