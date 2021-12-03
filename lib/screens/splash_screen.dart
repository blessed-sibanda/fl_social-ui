import 'package:flutter/material.dart';
import 'package:flutter_social/models/app_pages.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static get page => MaterialPage(
        child: const SplashScreen(),
        name: AppPages.splashPath,
        key: ValueKey(AppPages.splashPath),
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppProvider>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreen.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Flutter Social',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
