import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/base_api.dart';
import 'package:flutter_social/services/users_api.dart';
import 'package:flutter_social/widgets/email_input_field.dart';
import 'package:flutter_social/widgets/form_wrapper.dart';
import 'package:flutter_social/widgets/name_input_field.dart';
import 'package:flutter_social/widgets/password_input_field.dart';
import 'package:provider/provider.dart';

class EditUserForm extends StatefulWidget {
  final String userId;
  const EditUserForm({Key? key, required this.userId}) : super(key: key);

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _aboutController = TextEditingController();

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _error = '';

  final _usersApi = UsersApi();

  late User _user;

  void _loadData() {
    _usersApi.getUser(widget.userId).then((userJson) {
      setState(() {
        _user = User.fromJson(userJson);
        _nameController.text = _user.name;
        _emailController.text = _user.email!;
        // _aboutController.text = _user.about!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _aboutController.dispose();
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
            Text('Edit User'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4),
            const Divider(),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            TextInputField(label: 'Name', nameController: _nameController),
            // TextInputField(label: 'About', nameController: _aboutController),
            EmailInputField(emailController: _emailController),
            // PasswordInputField(controller: _passwordController),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () =>
                      Provider.of<AppProvider>(context, listen: false)
                          .goToProfile(),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  child: const Text('Update User'),
                  onPressed: _updateUser,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateUser() {
    print('i was clicked');
    if ((_formStateKey.currentState != null) &&
        (_formStateKey.currentState!.validate())) {
      print('i was called');
      User user = User(
        name: _nameController.text,
        email: _emailController.text,
        // password: _passwordController.text,
        // about: _aboutController.text,
      );
      _usersApi.updateUser(user).then((value) {
        print('Value');
        print(value);
        if (value is ServiceApiError) {
          setState(() => _error = value.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User details updated successfully!')),
          );
          Provider.of<AppProvider>(context, listen: false).goToProfile();
        }
      });
    }
  }
}
