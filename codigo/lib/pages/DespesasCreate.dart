import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DespesasCreate extends StatelessWidget {
  DespesasCreate({super.key});

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
                items: [DropdownMenuItem<String>(child:Text("Selecionar Frequência"))],
                onChanged: (Object? value) {  },
                style: const TextStyle(
                  color: Colors.white,
                ),
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
                style: const TextStyle(
                  color: Colors.white,
                ),
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
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}