import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/providers/app_provider.dart';
import 'package:flutter_social/services/users_api.dart';
import 'package:flutter_social/widgets/follow_button.dart';
import 'package:provider/provider.dart';

class WhoToFollow extends StatefulWidget {
  const WhoToFollow({Key? key}) : super(key: key);

  @override
  State<WhoToFollow> createState() => _WhoToFollowState();
}

class _WhoToFollowState extends State<WhoToFollow> {
  List<User> _usersToFollow = [];
  bool _loading = true;
  final _usersApi = UsersApi();
  Map<String, String> _usersAvatarUrls = {};

  void loadData() {
    _usersApi.findUsers().then((data) {
      List<User> usersList = [];
      Map<String, String> avatars = {};
      usersList = data.map((u) {
        var user = User.fromJson(u);
        avatars[user.id!] = _usersApi.userAvatarUrl(user.id!);
        return user;
      }).toList();
      setState(() {
        _usersToFollow = usersList;
        _usersAvatarUrls = avatars;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who To Follow',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            ),
          ),
          const SizedBox(height: 15.0),
          if (_loading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!_loading)
            Expanded(
              child: ListView.builder(
                itemCount: _usersToFollow.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  User user = _usersToFollow[index];
                  final avatarUrl = _usersAvatarUrls[user.id!];
                  return InkWell(
                    child: _buildUserTile(context, user, avatarUrl!),
                    onTap: () => _goToUserProfile(user),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _goToUserProfile(User user) =>
      Provider.of<AppProvider>(context, listen: false)
          .goToProfile(userId: user.id!);

  Widget _buildUserTile(BuildContext context, User user, String avatarUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        title: Text(user.name),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: Colors.transparent,
        ),
        trailing: FollowButton(followed: user, afterFollowCallback: loadData),
      ),
    );
  }
}
