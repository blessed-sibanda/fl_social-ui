import 'package:flutter/material.dart';
import 'package:fl_social/utils/form_validators.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      validator: (value) => FormValidators.userEmailField(value),
    );
  }
}
