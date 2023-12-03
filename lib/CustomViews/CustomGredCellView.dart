import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGredCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final String imagen;
  final double dFontSize;

  const CustomGredCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.imagen,
    required this.dFontSize});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
               //image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/kitymanuel-489a1.appspot.com/o/posts%2FZmKoioLe8UhTQaa00kQQwOaJlAE3%2Fimgs%2F1699621916168.jpg?alt=media&token=5e18f2e7-ca54-4c81-95e2-b4a35b7f23a3.jpg"),
                image: NetworkImage(imagen),
                fit: BoxFit.contain
            )
        ),
        color: Colors.amber[iColorCode],
        child: Column(
          children: [
            Image.asset("resources/imagenInicial.png",width: 70,
                height: 70),
            Text(sText,style: TextStyle(fontSize: dFontSize)),
            TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
          ],
        )
    );
  }
}
