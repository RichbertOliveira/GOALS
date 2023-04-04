import 'package:flutter/material.dart';

class Goals extends StatelessWidget {
  final String texto;

  Goals(this.texto);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            color: Colors.indigo[300],
            padding: const EdgeInsets.all(10.0),
            height: 100,
            width: 600,
            child: const Text(
              "Viagem para Paris"
              "\nR\$2500.00 / R\$5000.40"
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            color: Colors.indigo[300],
            padding: const EdgeInsets.all(10.0),
            height: 100,
            width: 600,
            child: const Text(
              "Viagem para Disney"
              "\nR\$1500.00 / R\$2500.89"
            ),
          ),
        ]
      ),

    );
  }
}