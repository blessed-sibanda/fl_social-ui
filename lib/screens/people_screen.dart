import 'package:flutter/material.dart';
import 'package:fl_social/navigation/app_paths.dart';
import 'package:fl_social/widgets/fl_social_appbar.dart';
import 'package:fl_social/widgets/who_to_follow.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: PeopleScreen(),
        name: AppPaths.userPath,
        key: ValueKey(AppPaths.userPath),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: FlSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: WhoToFollow(),
      ),
    );
  }
}
