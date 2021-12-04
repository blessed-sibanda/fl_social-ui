import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: PeopleScreen(),
        name: AppPages.userPath,
        key: ValueKey(AppPages.userPath),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: Center(child: Text('People')),
      ),
    );
  }
}
