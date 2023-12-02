import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../FirebaseObjects/FbPostId.dart';
import 'FirebaseAdmin.dart';


class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  String sNombre="Examen Dataholder";
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbadmin=FirebaseAdmin();

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


}