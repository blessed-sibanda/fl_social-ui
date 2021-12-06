import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_api.dart';

class WhoToFollow extends StatefulWidget {
  const WhoToFollow({Key? key}) : super(key: key);

  @override
  State<WhoToFollow> createState() => _WhoToFollowState();
}

class _WhoToFollowState extends State<WhoToFollow> {
  List<User> _usersToFollow = [];
  bool _loading = true;
  final _usersApi = UsersApi();
  final Map<String, String> _usersAvatarUrls = {};

  List<User> loadData() {
    List<User> usersList = [];

    _usersApi.findUsers().then((data) {
      usersList = data.map((u) {
        var user = User.fromJson(u);
        setState(() {
          _usersAvatarUrls[user.id!] = _usersApi.userAvatarUrl(user.id!);
        });
        return user;
      }).toList();
      setState(() {
        _usersToFollow = usersList;
        _loading = false;
      });
    });

    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    loadData();
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
                  return ListTile(
                    title: Text(user.name),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(avatarUrl ?? ''),
                      backgroundColor: Colors.transparent,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _usersApi.followUser(user.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('You are now following ${user.name}'),
                              ),
                            );
                          },
                          child: const Text('Follow'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
