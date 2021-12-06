import 'package:flutter/material.dart';
import 'package:flutter_social/utils/form_validators.dart';

class NameInputField extends StatelessWidget {
  const NameInputField({
    Key? key,
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
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (value) => FormValidators.userNameField(value),
    );
  }
}
