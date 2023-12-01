import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final Function? prueba;
  final String texto;
  CustomButton({
    Key? key,
    this.prueba,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (prueba != null) {
          prueba!();
        }
      },
      child: Text(texto),
    );
  }
}