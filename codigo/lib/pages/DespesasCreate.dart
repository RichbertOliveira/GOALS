import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goals/model/Expenses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../database/DatabaseHelper.dart';
import '../database/ExpensesDb.dart';
import '../main.dart';
import 'Despesas.dart';

class DespesasCreate extends StatefulWidget {
  @override
  State<DespesasCreate> createState() => _DespesasCreateState();
}

class _DespesasCreateState extends State<DespesasCreate> {
  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final frequencyController = TextEditingController();
  final typeController = TextEditingController();
  var _frequency = null;
  var _type = null;

  void saveDespesa(String name, double value, String frequency, String type) async {
    Database database = await DatabaseHelper.createDatabase();
    final ExpensesDb expensesFile = ExpensesDb();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var expense = Expenses(
      id: await expensesFile.findLastId(database),
      name: name,
      value: value,
      frequency: frequency,
      type: type,
      userId: prefs.getInt('userId')!,
    );

    await expensesFile.insertExpenses(expense, database);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Inicio())
    );
  }

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
                style: const TextStyle(fontSize: 15, color: Colors.white),
                keyboardType: TextInputType.text,
                controller: nameController,
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
                keyboardType: TextInputType.number,
                controller: valueController,
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
              decoration: BoxDecoration(
                color: Colors.indigo[300],
              ),
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                hint: const Text("Selecionar Frequência",
                style: const TextStyle(
                  color: Colors.white,
                )),
                items: const [
                  DropdownMenuItem<String>(value: 'DIARIO',child:Text("Diário"),),
                  DropdownMenuItem<String>(value: 'SEMANAL',child:Text("Semanal"),),
                  DropdownMenuItem<String>(value: 'MENSAL',child:Text("Mensal"),),
                  DropdownMenuItem<String>(value: 'ANUAL',child:Text("Anual"),),
                ],
                onChanged: (Object? value) {
                  setState(() {
                    _frequency = value;
                  });
                },
                dropdownColor: Colors.indigo[300],
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.indigo[300],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.indigo[300],
              ),
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField<String>(
                hint: const Text("Selecionar Tipo de Despesa",
                style: const TextStyle(
                  color: Colors.white,
                )),
                items: [
                  DropdownMenuItem<String>(child:Text("Obrigatória Fixa"), value: 'FM',),
                  DropdownMenuItem<String>(child:Text("Obrigatória Variável"), value: 'VM',),
                  DropdownMenuItem<String>(child:Text("Não-Obrigatória Fixa"), value: 'FNM',),
                  DropdownMenuItem<String>(child:Text("Não-Obrigatória Variável"), value: 'VNM',),
                ],
                onChanged: (Object? value) {
                  setState(() {
                    _type = value;
                  });
                },
                dropdownColor: Colors.indigo[300],
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.indigo[300],
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
                    saveDespesa(nameController.text, double.parse(valueController.text), _frequency, _type);
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