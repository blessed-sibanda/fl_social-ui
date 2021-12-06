import 'package:flutter/material.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: UserProfileScreen(),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
      );

  @override
  Widget build(BuildContext context) {
    final selectedUser = Provider.of<AppProvider>(context).selectedUser;
    return Scaffold(
      appBar: const PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: Center(child: Text('User Profile - $selectedUser')),
      ),
    );
  }
}
