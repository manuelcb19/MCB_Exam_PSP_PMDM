import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home/EditarPost.dart';

class CustomGredCellView extends StatelessWidget{

  final String sText;
  final String usuario;
  final String tituloPost;
  final int iColorCode;
  final String imagen;
  final double dFontSize;
  final String idPost;

  const CustomGredCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.imagen,
    required this.dFontSize,
    required this.usuario,
    required this.idPost,
    required this.tituloPost});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Clic en la imagen");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditarPost(postId: idPost),
          ),
        );
      },
      child: Container(
        height: 600, width: 600,
        decoration: BoxDecoration(
          image: DecorationImage(opacity: 0.3, image: NetworkImage(imagen), fit: BoxFit.cover,
          ),
        ),
        color: Colors.amber[iColorCode],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Usuario: " + usuario, style: TextStyle(fontSize: dFontSize)),
            Text(tituloPost, style: TextStyle(fontSize: dFontSize)),
            Text(sText, style: TextStyle(fontSize: dFontSize)),
            TextButton(
              onPressed: null,
              child: Text("+", style: TextStyle(fontSize: dFontSize)),
            ),
          ],
        ),
      ),
    );
  }
}
