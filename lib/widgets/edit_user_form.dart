import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_social/models/user.dart';
import 'package:fl_social/providers/app_provider.dart';
import 'package:fl_social/services/base_api.dart';
import 'package:fl_social/services/users_api.dart';
import 'package:fl_social/utils/text_utils.dart';
import 'package:fl_social/widgets/email_input_field.dart';
import 'package:fl_social/widgets/form_wrapper.dart';
import 'package:fl_social/widgets/text_input_field.dart';
import 'package:fl_social/widgets/password_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  String _userAvatarUrl = '';
  PickedFile? _image;

  final _usersApi = UsersApi();

  late User _user;

  void _loadData() {
    _usersApi.getUser(widget.userId).then((userJson) {
      setState(() {
        _user = User.fromJson(userJson);
        _userAvatarUrl = _usersApi.userAvatarUrl(_user.id!);
        _nameController.text = _user.name;
        _emailController.text = _user.email!;
        _aboutController.text = _user.about ?? '';
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
            TextUtils.cardHeaderText(context, 'Edit Profile'),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image == null
                      ? NetworkImage(_userAvatarUrl)
                      : (kIsWeb
                          ? NetworkImage(_image!.path)
                          : FileImage(File(_image!.path)) as ImageProvider),
                  foregroundColor: Colors.grey.shade200,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 13.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      onPressed: null,
                      disabledColor: Colors.grey.shade200,
                      child: Row(
                        children: const [
                          Text('Upload Image'),
                          Icon(Icons.upload),
                        ],
                      ),
                      elevation: 1.0,
                    ),
                    if (!kIsWeb)
                      IconButton(
                          onPressed: () async {
                            var image = await ImagePicker.platform
                                .pickImage(source: ImageSource.camera);
                            setState(() => _image = image);
                          },
                          color: Theme.of(context).primaryColor,
                          tooltip: 'Take Photo',
                          icon: const Icon(Icons.camera_alt_outlined)),
                    IconButton(
                        onPressed: () async {
                          var image = await ImagePicker.platform
                              .pickImage(source: ImageSource.gallery);
                          setState(() => _image = image);
                        },
                        color: Theme.of(context).primaryColor,
                        tooltip: 'Select Image',
                        icon: const Icon(Icons.image)),
                  ],
                )
              ],
            ),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            TextInputField(label: 'Name', controller: _nameController),
            TextInputField(
              label: 'About',
              controller: _aboutController,
              multiLine: true,
              validator: (_) {},
            ),
            EmailInputField(emailController: _emailController),
            PasswordInputField(controller: _passwordController, onEdit: true),
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

  String? get _imagePath {
    if (_image == null) return null;
    return File(_image!.path).absolute.path; // only works in non-web
  }

  void _updateUser() {
    if ((_formStateKey.currentState != null) &&
        (_formStateKey.currentState!.validate())) {
      User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password:
            _passwordController.text.isEmpty ? null : _passwordController.text,
        about: _aboutController.text,
      );

      _usersApi.updateUser(user, _imagePath).then((value) {
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
