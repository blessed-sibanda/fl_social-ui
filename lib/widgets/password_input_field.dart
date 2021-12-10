import 'package:fl_social/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_social/utils/form_validators.dart';
import 'package:provider/provider.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool onEdit;
  final String? label;

  const PasswordInputField({
    Key? key,
    required this.controller,
    this.label = 'Password',
    this.onEdit = false,
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
        labelText: widget.label!,
        suffix: GestureDetector(
          onTap: _toggleObscurePassword,
          child: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black45,
          ),
        ),
        helperText: widget.onEdit && widget.label == 'Password'
            ? 'Leave this field blank if you do not want to change your password'
            : null,
        helperMaxLines: 2,
      ),
      validator: (value) =>
          Provider.of<PasswordProvider>(context, listen: false).isInvalid &&
                  widget.label != 'Password'
              ? '${widget.label} is invalid'
              : FormValidators.userPasswordField(
                  value,
                  allowBlank: widget.onEdit && widget.label == 'Password',
                  label: widget.label!,
                ),
    );
  }
}
