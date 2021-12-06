import 'package:flutter/material.dart';
import 'package:flutter_social/navigation/app_paths.dart';
import 'package:flutter_social/widgets/flutter_social_appbar.dart';
import 'package:flutter_social/widgets/who_to_follow.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static get page => const MaterialPage(
        child: HomeScreen(),
        name: AppPaths.homePath,
        key: ValueKey(AppPaths.homePath),
      );

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = false;
    if (MediaQuery.of(context).size.width < 600) isSmallScreen = true;
    return Scaffold(
      appBar: const PreferredSize(
        child: FlutterSocialAppBar(),
        preferredSize: Size.fromHeight(56.0),
      ),
      body: SafeArea(
        child: Row(
          children: [
            const Expanded(
              child: Text('Post Feed'),
              flex: 2,
            ),
            if (!isSmallScreen)
              const Expanded(
                flex: 1,
                child: Card(
                  child: WhoToFollow(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
