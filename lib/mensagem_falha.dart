import 'package:flutter/material.dart';

mensagemDeFalha(BuildContext context, String nome) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        'A operação Falhou!',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content:
      Text(' não está preenchido'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}