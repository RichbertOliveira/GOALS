import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  final String texto;

  Sobre(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(5.0),
            color: Colors.indigo[200],
            child: const Text(
                "GOALS é o aplicativo criado com a intenção de ajudar seus usuários a controlar suas finanças de forma fácil, "
                "gamificada e rápida. Possibilitando o gerenciamento de despesas e estabelecendo limites para cada uma delas"
                "Primeiro, você precisa ter consciência do que você gasta e dar nome pra cada uma delas, dando espaço para o usuário ter clareza sobre"
                "suas próprias despesas. Você com certeza vai encontrar um gasto que nem deveria estar ali. Ao terminar de dar nome, você terá um resultado."
                "Se esse saldo for positivo, parabéns, você pode direcionar para seus GOALS, que são seus objetivos, o que você quiser fazer."
                "\n\nGuardar dinheiro para investir na sua liberdade de escolha nunca foi uma escolha tão fácil."
                "\n\nSara Iglesias foi quem idealizou a ideia do aplicativo, e juntamente com ela, Caio Magnani, Italo Lellis e Richbert Oliveira"
                " desenvolveram o aplicativo.",
              style: TextStyle(
                fontFamily: "Times New Roman",
              ),
            ),
          ),
      ),
    );
  }
}