import 'package:flutter/material.dart';
import 'package:flutter_social/pages/home.dart';
import 'package:flutter_social/pages/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      routes: {
        '/x': (context) => const HomePage(),
        '/': (context) => const SignUpPage(),
      },
    );
  }
}
