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

  List<User> getUsers() {
    final _usersApi = UsersApi();
    List<User> usersList = [];

    _usersApi.findUsers().then((data) {
      usersList = data.map((u) {
        return User.fromJson(u);
      }).toList();
      setState(() {
        _usersToFollow = usersList;
        _loading = false;
      });
    });

    return usersList;
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Who To Follow'),
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
                return ListTile(
                  title: Text(user.name),
                );
              },
            ),
          ),
      ],
    );
  }
}
