import 'package:flutter/material.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/utils/screen_size.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const PreferredSize(
          child: FlutterSocialAppBar(),
          preferredSize: Size.fromHeight(56.0),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: ScreenSize.minPadding(context),
              child: SizedBox(
                width: 600,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 15.0, 0, 0),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline6!.fontSize,
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      UserInfo(userId: selectedUser),
                      const SizedBox(height: 15.0),
                      const TabBar(
                        tabs: [
                          Tab(text: 'Posts'),
                          Tab(text: 'Following'),
                          Tab(text: 'Followers'),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            Icon(Icons.directions_car),
                            Icon(Icons.directions_transit),
                            Icon(Icons.directions_bike),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
