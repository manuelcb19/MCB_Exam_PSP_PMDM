import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario{

   String nombre;
   int edad;
   String shint;

  FbUsuario ({
    required this.nombre,
    required this.edad,
    required this.shint,
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
        shint: data?['sHint'] != null ? data!['sHint'] : "",
        nombre: data?['nombre'] != null ? data!['nombre'] : "",
        edad: data?['edad'] != null ? data!['edad'] : 0
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (edad != null) "edad": edad,
      if (shint != null) "shint": shint,
    };
  }
}