import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputs extends StatelessWidget {
  final TextEditingController nomeController;
  final String labelContent;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validation;
  final int charAmount;

  const FormInputs(
    this.labelContent,
    this.charAmount, {
    Key? key,
    this.type,
    this.inputFormatters,
    required this.validation,
    required this.nomeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelContent,
              labelStyle: const TextStyle(
                fontSize: 18,
              ),
            ),
            inputFormatters: inputFormatters,
            controller: nomeController,
            maxLength: charAmount,
            keyboardType: type,
            validator: validation,
          ),
        ),
      ],
    );
  }
}
