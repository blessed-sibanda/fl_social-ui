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
          Text('Who To Follow', style: Theme.of(context).textTheme.headline5),
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
                  return _buildUserTile(context, user, avatarUrl!);
                },
              ),
            ),
        ],
      ),
    );
  }

  ListTile _buildUserTile(BuildContext context, User user, String avatarUrl) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(avatarUrl),
        backgroundColor: Colors.transparent,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => Provider.of<AppProvider>(context, listen: false)
                .goToProfile(userId: user.id!),
            icon: const Icon(Icons.visibility),
          ),
          FollowButton(followed: user, afterFollowCallback: loadData),
        ],
      ),
    );
  }
}
