import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  final String texto;

  Cadastro(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(texto),
      ),
    );
  }
}