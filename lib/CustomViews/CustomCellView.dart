import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCellView extends StatelessWidget {

  final String sTexto;
  final int iCodigoColor;
  final double dFuenteTamanyo;
  final int iPosicion;
  final String imagen;
  final Function(int indice) onItemListClickedFun;

  const CustomCellView({super.key,

    required this.sTexto,
    required this.iCodigoColor,
    required this.dFuenteTamanyo,
    required this.iPosicion,
    required this.imagen,
    required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(20),
        height: 600,
        width: 600,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: NetworkImage(imagen),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: Text(
                "usuario",
                style: TextStyle(fontSize: dFuenteTamanyo, color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: TextButton(
                onPressed: null,
                child: Text("+", style: TextStyle(fontSize: dFuenteTamanyo, color: Colors.white)),
              ),
            ),
            Positioned(
              bottom: -10,
              left: 10,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Añadir un comentario...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // Agrega tu lógica para manejar el envío del comentario
                      },
                      child: Text(
                        'Enviar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onItemListClickedFun(iPosicion);
        //print("tapped on container " + iPosicion.toString());
      },
    );
  }
}