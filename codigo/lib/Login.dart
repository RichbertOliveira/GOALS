import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String texto;

  Login(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(texto),
      ),
    );
  }
}