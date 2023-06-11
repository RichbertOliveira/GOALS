import 'package:flutter/material.dart';

class CardDespesaDetalhes extends StatelessWidget {
  final Function? onTap;
  final String texto;
  final double valor;

  const CardDespesaDetalhes({
    Key? key,
    required this.texto,
    this.valor = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.redAccent, // Set the desired border color here
          width: 5.0, // Set the desired border width here
        ),
      ),
      child: Material(
        color: Colors.redAccent,
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 600,
            child: Text(
              "$texto \n R\$ ${valor.toStringAsFixed(2)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
