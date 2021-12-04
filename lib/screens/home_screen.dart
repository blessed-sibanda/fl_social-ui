import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: const HomeScreen(),
        name: AppPages.homePath,
        key: ValueKey(AppPages.homePath),
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: Center(child: Text('Home')),
      ),
    );
  }
}
