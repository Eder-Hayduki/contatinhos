import 'package:brasil_fields/brasil_fields.dart';
import 'package:contatinhos/database/dao/contatinhos_dao.dart';
import 'package:contatinhos/home_page.dart';

import 'package:contatinhos/textboxes/form_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'models/contact.dart';

class AlterarContato extends StatefulWidget {
  final Contact modifiedContact;

  const AlterarContato({Key? key, required this.modifiedContact}) : super(key: key);

  @override
  _AlterarContatoState createState() => _AlterarContatoState(modifiedContact);
}

class _AlterarContatoState extends State<AlterarContato> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final ContatinhosDao dao = ContatinhosDao();
  final Contact modifiedContact;

  _AlterarContatoState(this.modifiedContact);

  @override
  void initState() {
    super.initState();
    _nomeController =
        TextEditingController(text: modifiedContact.nome);
    _emailController =
        TextEditingController(text: modifiedContact.email);
    _phoneController =
        TextEditingController(text: modifiedContact.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Contato'),
      ),
      body: Column(
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
          const Padding(padding: EdgeInsets.only(top: 10)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 18,
                  right: 18,
                ),
                child: Text(
                  'Alterar Contato',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onPressed: () => _modificarContato(context),
            ),
          ),
        ],
      ),
    );
  }

  void _modificarContato(BuildContext context) {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;

    final editingContact = Contact(modifiedContact.id, nome, email, phone);

    dao.modifyContact(editingContact).then(
          (id) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
    );
  }
}
