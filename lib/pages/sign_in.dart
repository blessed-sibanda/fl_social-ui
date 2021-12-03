import 'package:flutter/material.dart';
import 'package:flutter_social/services/auth_api.dart';
import 'package:flutter_social/services/base_api.dart';
import 'package:flutter_social/utils/form_validators.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthApi _authApi;

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _error = '';

  @override
  void initState() {
    super.initState();
    _authApi = AuthApi();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formStateKey,
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26.0,
                  vertical: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sign In'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4),
                    const Divider(),
                    if (_error.isNotEmpty)
                      Text(_error, style: const TextStyle(color: Colors.red)),
                    TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) =>
                          FormValidators.userEmailField(value),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) =>
                          FormValidators.userPasswordField(value),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Sign-up instead'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/');
                          },
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          child: const Text('Sign In'),
                          onPressed: _signIn,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formStateKey.currentState!.validate()) {
      _authApi
          .signIn(_emailController.text, _passwordController.text)
          .then((value) {
        if (value is ServiceApiError) {
          setState(() => _error = value.message);
        } else {
          print(value);
          Navigator.of(context).pushNamed('/home');
        }
      });
    }
  }
}
