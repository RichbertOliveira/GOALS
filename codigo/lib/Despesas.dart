import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _EditDespesasState())
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              height: 100,
              width: 600,
              child: const Text(
                "Viagem para Paris"
                    "\nR\$2500.00 / R\$5000.40",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _EditDespesasState())
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              height: 100,
              width: 600,
              child: const Text(
                "Viagem para Disney"
                    "\nR\$1500.00 / R\$2500.89",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _EditDespesasState())
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              height: 100,
              width: 600,
              child: const Text(
                "Comprar geladeira nova"
                    "\nR\$200.00 / R\$2000.00",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _CadDespesasState())
              );
            },
            child: const Icon(Icons.add),
          )
        ]
      ),
    );
  }
}


class _CadDespesasState extends StatelessWidget {
  _CadDespesasState({super.key});

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
                style: const TextStyle(fontSize: 15, color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
            Row(
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
                initialValue: "Viagem para Disney",
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
                initialValue: "2500.89",
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
              child: TextFormField(
                initialValue: "1500.00",
                keyboardType: TextInputType.number,
                readOnly: true,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Guardado: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              color: Colors.indigo[300],
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Valor a retirar ou guardar: ",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Retirar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
            Container(height: 100,),
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
                  child: const Text('Deletar Goal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
