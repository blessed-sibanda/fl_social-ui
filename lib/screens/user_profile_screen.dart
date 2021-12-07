import 'package:flutter/material.dart';
import 'package:fl_social/providers/app_provider.dart';
import 'package:fl_social/utils/screen_size.dart';
import 'package:fl_social/utils/text_utils.dart';
import 'package:fl_social/widgets/user_info.dart';
import 'package:fl_social/navigation/app_paths.dart';
import 'package:fl_social/widgets/fl_social_appbar.dart';
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
          child: FlSocialAppBar(),
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
                      TextUtils.cardHeaderText(context, 'Profile'),
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
