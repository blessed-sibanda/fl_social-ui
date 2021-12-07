import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/auth_page_provider.dart';
import 'package:flutter_social/services/users_api.dart';
import 'package:flutter_social/services/base_api.dart';
import 'package:flutter_social/widgets/email_input_field.dart';
import 'package:flutter_social/widgets/form_wrapper.dart';
import 'package:flutter_social/widgets/text_input_field.dart';
import 'package:flutter_social/widgets/password_input_field.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _error = '';

  late UsersApi _usersApi;

  @override
  void initState() {
    super.initState();
    _usersApi = UsersApi();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      child: FormWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign Up'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4),
            const Divider(),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            TextInputField(label: 'Name', controller: _nameController),
            EmailInputField(emailController: _emailController),
            PasswordInputField(controller: _passwordController),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Sign-in instead'),
                  onPressed: () {
                    Provider.of<AuthPageProvider>(context, listen: false)
                        .goToSignIn();
                  },
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: _signUpUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUpUser() {
    if ((_formStateKey.currentState != null) &&
        (_formStateKey.currentState!.validate())) {
      User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      _usersApi.createUser(user).then((value) {
        if (value is ServiceApiError) {
          setState(() => _error = value.message);
        } else {
          _showDialog(value);
        }
      });
    }
  }

  Future<void> _showDialog(value) async {
    var authPageProvider =
        Provider.of<AuthPageProvider>(context, listen: false);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ChangeNotifierProvider<AuthPageProvider>(
          create: (_) => authPageProvider,
          child: AlertDialog(
            title: Text(value),
            content: const Text('You can now sign-in'),
            actions: [
              TextButton(
                child: const Text('Sign In'),
                onPressed: () {
                  authPageProvider.goToSignIn();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
