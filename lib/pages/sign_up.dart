import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_api.dart';
import 'package:flutter_social/utils/form_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    Text('Sign Up'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4),
                    const Divider(),
                    if (_error.isNotEmpty)
                      Text(_error, style: const TextStyle(color: Colors.red)),
                    TextFormField(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) => FormValidators.userNameField(value),
                    ),
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
                          child: const Text('Sign-in instead'),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/signin');
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
            ),
          ),
        ),
      ),
    );
  }

  void _signUpUser() {
    if (_formStateKey.currentState!.validate()) {
      User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      _usersApi.createUser(user).then((value) {
        if (value is ServiceApiError) {
          setState(() => _error = value.message);
        } else {
          Navigator.of(context).pushNamed('/signin');
        }
      });
    }
  }
}
