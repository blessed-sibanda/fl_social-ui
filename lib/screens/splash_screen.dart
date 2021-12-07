import 'package:flutter/material.dart';
import 'package:fl_social/navigation/app_paths.dart';
import 'package:fl_social/providers/app_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static get page => const MaterialPage(
        child: SplashScreen(),
        name: AppPaths.splashPath,
        key: ValueKey(AppPaths.splashPath),
      );

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).initializeApp();
    return Scaffold(
      body: Container(
        color: Colors.lightGreen.shade50,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fl-Social',
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
