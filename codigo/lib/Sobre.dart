import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  final String texto;

  Sobre(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("GOALS é o aplicativo criado com a intenção de ajudar seus usuários a controlar suas finanças de forma fácil "
          "e rápida. Possibilitando uma manutenção dos gastos e visualização do que pode ser retirado das contas no final do mês."
          "\n\nSara Iglesias foi quem idealizou a ideia do aplicativo, e juntamente com ela, Caio Magnani, Italo Lellis e Richbert Oliveira"
          " desenvolveram o aplicativo."),
    );
  }
}