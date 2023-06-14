import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

import 'package:firebase_auth/firebase_auth.dart';

import 'Goals.dart';
import 'Login.dart';
import 'Sobre.dart';
import 'pages/Despesas.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: const Login(),
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    Despesas(despesas: "Despesas"),
    Goals(goals: "Goals"),
    Sobre("Sobre"),
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center (
          child: Center(child: Text("Goals")),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
          children: [
            _telas[_indiceAtual],
          ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (int index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        selectedIndex: _indiceAtual,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.payment),
            label: 'Despesas',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Goals',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outline),
            label: 'Sobre',
          ),
        ],
      ),
    );
  }
}
