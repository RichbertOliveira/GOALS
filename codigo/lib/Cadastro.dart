import 'package:flutter/material.dart';
import 'package:goals/Login.dart' show Login;
import 'main.dart';

class Cadastro extends StatelessWidget {

  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Column(
        children: [
          const Center(
            child: Text(
              "Goals",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                decoration: TextDecoration.none,
              ),
            ),
          ), //Header
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(255, 127, 80, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Color.fromRGBO(255, 127, 80, 1),
                          ))),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 127, 80, 1),
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inicio()),
                    );
                  },
                ), //BtnLogin
                TextButton(
                  child: const Text(
                    "Já tem conta? Faça o login aqui!",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 127, 80, 1),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login()),
                    );
                  },
                ), //Cadastrar
              ],
            ),
          ), //Form
        ],
      ),
    );
  }
}
