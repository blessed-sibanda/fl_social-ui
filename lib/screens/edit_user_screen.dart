import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/widgets/edit_user_form.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatelessWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: EditUserScreen(),
        name: AppPaths.userEditPath,
        key: ValueKey(AppPaths.userEditPath),
      );

  @override
  Widget build(BuildContext context) {
    final selectedUser =
        Provider.of<AppProvider>(context, listen: false).selectedUser;
    return Scaffold(
      appBar: const PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: EditUserForm(userId: selectedUser),
    );
  }
}
