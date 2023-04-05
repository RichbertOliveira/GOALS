import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardDespesaDetalhes extends StatelessWidget {
  final Function? onTap;
  final String texto;
  final double valor;

  const CardDespesaDetalhes(
    {Key? key,
      required this.texto,
      this.valor = 0,
      this.onTap,
    })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.indigo[300],
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 600,
            child: Text(
              "$texto \n R\$ $valor",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

}