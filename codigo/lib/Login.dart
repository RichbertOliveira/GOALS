import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:goals/database/DatabaseHelper.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:goals/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Cadastro.dart';
// import 'database/UserDAO.dart';
// import 'model/User.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _mensageError = "";

  void _formSubmit() async {
    if (_formKey.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        final userId = credential.user?.uid ?? "";
        var loggedUser = prefs.setString('userId', userId);

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Inicio()),
          );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _mensageError = 'O usuário não foi encontrado';
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            _mensageError = 'Verifique seu e-mail e senha';
          });
        }
      }
    } else {
      setState(() {
        _mensageError = "Verifique seu e-mail e senha";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const Center(
            child: Text(
              "Goals",
              style: TextStyle(
                fontSize: 42,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(48, 18, 48, 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value!;
                    },
                  ), // Email
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value!;
                    },
                  ), // Password
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      _mensageError,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Center(
                    child: OutlinedButton(
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.fromLTRB(80, 10, 80, 10))),
                        onPressed: _formSubmit,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(255, 127, 80, 1),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            child: const Text(
              "Não tem conta? Crie sua conta aqui!",
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
                MaterialPageRoute(builder: (context) => Cadastro()),
              );
            },
          ),
        ],
      ),
    );
  }
}
