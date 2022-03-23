import 'package:brasil_fields/brasil_fields.dart';
import 'package:contatinhos/database/dao/contatinhos_dao.dart';
import 'package:contatinhos/home_page.dart';
import 'package:contatinhos/textboxes/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

import 'models/contact.dart';

class CadastrarContato extends StatefulWidget {
  const CadastrarContato({Key? key}) : super(key: key);

  @override
  _CadastrarContatoState createState() => _CadastrarContatoState();
}

class _CadastrarContatoState extends State<CadastrarContato> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final ContatinhosDao dao = ContatinhosDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Contato'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            FormInputs('Nome:', 125, validation: (value) {
              if (value!.isEmpty) {
                return 'Por favor, digite seu nome';
              }
              if (value.length < 2) {
                return 'Nome inválido';
              }
              return null;
            }, nomeController: _nomeController),
            FormInputs(
              'Email',
              125,
              validation: (value) => Validator.email(value)
                  ? 'Por favor, digite um email válido'
                  : null,
              nomeController: _emailController,
              type: TextInputType.emailAddress,
            ),
            FormInputs(
              'Celular:',
              16,
              validation: (value) => Validator.phone(value)
                  ? 'Por favor, digite um número de telefone'
                  : null,
              nomeController: _phoneController,
              type: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 18,
                    right: 18,
                  ),
                  child: Text(
                    'Cadastrar contato',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    contactAdd(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void contactAdd(BuildContext context) {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    if (nome.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      final newContact = Contact(0, nome, email, phone);
      dao.saveContact(newContact).then(
            (id) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          );
    }
  }
}
