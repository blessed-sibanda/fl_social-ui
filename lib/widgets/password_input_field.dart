import 'package:flutter/material.dart';
import 'package:flutter_social/utils/form_validators.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscurePassword = true;

  void _toggleObscurePassword() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Password',
        suffix: GestureDetector(
          onTap: _toggleObscurePassword,
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black45,
          ),
        ),
      ),
      validator: (value) => FormValidators.userPasswordField(value),
    );
  }
}
