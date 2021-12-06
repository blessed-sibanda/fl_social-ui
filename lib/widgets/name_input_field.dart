import 'package:flutter/material.dart';
import 'package:flutter_social/utils/form_validators.dart';

class TextInputField extends StatelessWidget {
  final String label;
  const TextInputField({
    Key? key,
    required this.label,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) => FormValidators.userNameField(value),
    );
  }
}
