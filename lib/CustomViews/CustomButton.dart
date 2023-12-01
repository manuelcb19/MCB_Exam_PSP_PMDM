import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Function? funcion;
  final String texto;
  CustomButton({
    Key? key,
    this.funcion,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (funcion != null) {
          funcion!();
        }
      },
      child: Text(texto),
    );
  }
}