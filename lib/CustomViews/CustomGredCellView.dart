import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGredCellView extends StatelessWidget{

  final String sText;
  final String usuario;
  final String tituloPost;
  final int iColorCode;
  final String imagen;
  final double dFontSize;

  const CustomGredCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.imagen,
    required this.dFontSize,
    required this.usuario,
    required this.tituloPost});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 600,
        width: 600,
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.3,
                image: NetworkImage(imagen),
                fit: BoxFit.contain
            )
        ),
        color: Colors.amber[iColorCode],
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("usuario:" + usuario,style: TextStyle(fontSize: dFontSize)),
            Text(tituloPost,style: TextStyle(fontSize: dFontSize)),
            Text(sText,style: TextStyle(fontSize: dFontSize)),
            TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
          ],
        )
    );
  }
}
