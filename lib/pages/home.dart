import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: const HomePage(),
      name: AppPages.homePath,
      key: ValueKey(AppPages.homePath),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Social'),
      ),
      body: Container(),
    );
  }
}
