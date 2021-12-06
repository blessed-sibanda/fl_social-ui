import 'package:flutter/material.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/widgets/user_info.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: UserProfileScreen(),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
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
      body: SafeArea(
        child: Column(
          children: [
            UserInfo(userId: selectedUser),
          ],
        ),
      ),
    );
  }
}
