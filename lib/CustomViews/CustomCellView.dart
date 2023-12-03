import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCellView extends StatelessWidget {

  final String sTexto;
  final int iCodigoColor;
  final double dFuenteTamanyo;
  final int iPosicion;
  final String imagen;
  final String usuario;
  final String tituloPost;
  final Function(int indice) onItemListClickedFun;

  const CustomCellView({super.key,

    required this.sTexto,
    required this.iCodigoColor,
    required this.dFuenteTamanyo,
    required this.iPosicion,
    required this.imagen,
    required this.onItemListClickedFun,
    required this.usuario,
    required this.tituloPost});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                usuario,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dFuenteTamanyo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                tituloPost,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dFuenteTamanyo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("Clic en la imagen");
                Navigator.of(context).pushNamed("/editarperfil");
              },
              child: Image.network(
                imagen,
                height: 600.0,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                tituloPost,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dFuenteTamanyo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}