import "package:flutter/material.dart";

import 'Goals.dart';
import 'Login.dart';
import 'Cadastro.dart';
import 'Sobre.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Inicio(),
  ));
}

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    Home("Início"),
    Login("Login"),
    Cadastro("Cadastro"),
    Goals("Goals"),
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
        title: Center (
          child: Text("GOALS"),
        ),
      ),
      backgroundColor: Colors.red[200],
      body: Container(
        child: _telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Login",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Cadastro",backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Goals", backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.accessibility), label: "Sobre", backgroundColor: Colors.black),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String texto;

  Home(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(texto),
      ),
    );
  }
}
