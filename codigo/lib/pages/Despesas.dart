import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:goals/components/CardDespesaDetalhes.dart';
import 'package:goals/pages/DespesasCreate.dart';

class Despesas extends StatelessWidget {
  final String texto;

  Despesas(this.texto, {super.key});

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CardDespesaDetalhes(
            texto: "Despesas Obrigatórias Fixas",
            valor: 400.00,
          ),
          const CardDespesaDetalhes(
            texto: "Despesas Obrigatórias Variáveis",
            valor: 100.00,
          ),
          const CardDespesaDetalhes(
            texto: "Despesas Não-Obrigatórias Fixas",
            valor: 80.00,
          ),
          const CardDespesaDetalhes(
            texto: "Despesas Não-Obrigatórias Variáveis",
            valor: 20.00,
          ),

          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DespesasCreate())
              );
            },
            child: const Icon(Icons.add),
          )
        ]
      ),
    );
  }
}

class _EditDespesasState extends StatelessWidget {
  _EditDespesasState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: const Text('Cadastro de Despesa'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: "Supermercado",
                style: const TextStyle(fontSize: 15, color: Colors.white),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nome da Despesa: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o nome da Despesa';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: "300.00",
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Valor da Despesa: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
                validator: (String? nomeGoal) {
                  if(nomeGoal == null || nomeGoal == '') {
                    return 'Digite o valor da Despesa';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                items: [DropdownMenuItem<String>(child:Text("Selecionar Frequência")),],
                onChanged: (Object? value) {  },
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                items: [DropdownMenuItem<String>(child:Text("Selecionar Tipo de Despesa")),],
                onChanged: (Object? value) {  },
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Salvas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}