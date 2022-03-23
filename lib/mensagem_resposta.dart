import 'package:flutter/material.dart';

mensagemDeResposta(BuildContext context, String nome) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        'Sucesso!',
        style: TextStyle(
          color: Colors.green,
        ),
      ),
      content: Text('O Contato ' + nome),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      ],
    ),
  );
}
