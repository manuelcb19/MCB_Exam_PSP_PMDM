import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function(int indice)? onBotonesClicked;
  final Function()? onPressed;
  final String texto;

  CustomButton({
    Key? key,
    this.onBotonesClicked,
    this.onPressed,
    required this.texto,
  }) : super(key: key);

  void fNombre1() {
    print("DAM1 --->>>" + texto);
  }

  void fNombre2() {
    print("DAM2 --->>>" + texto);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (onBotonesClicked != null)
          ...[
            TextButton(
              onPressed: onBotonesClicked != null ? () => onBotonesClicked!(0) : null,
              child: Icon(Icons.list, color: Colors.pink),
            ),
            TextButton(
              onPressed: onBotonesClicked != null ? () => onBotonesClicked!(1) : null,
              child: Icon(Icons.grid_view, color: Colors.pink),
            ),
            IconButton(
              onPressed: onBotonesClicked != null ? () => onBotonesClicked!(2) : null,
              icon: Image.asset("resources/imageninicial.png"),
            ),
            TextButton(
              onPressed: onBotonesClicked != null ? () => onBotonesClicked!(3) : null,
              child: Text(texto), // Usamos la variable texto aquí
            ),
          ],
        if (onPressed != null)
          TextButton(
            onPressed: () {
              onPressed!();
            },
            child: Text(texto),
          ),
      ],
    );
  }
}