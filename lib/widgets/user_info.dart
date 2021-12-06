import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_api.dart';
import 'package:flutter_social/utils/app_cache.dart';
import 'package:flutter_social/widgets/follow_button.dart';

class UserInfo extends StatefulWidget {
  final String userId;

  const UserInfo({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _loading = true;
  final _usersApi = UsersApi();
  String _userAvatarUrl = '';
  late User _user;
  bool _isFollowing = false;

  void _loadData() async {
    _usersApi.getUser(widget.userId).then((userJson) {
      AppCache().currentUser().then((currentUser) {
        for (var u in _user.followers!) {
          if (u.id == currentUser.id!) {
            setState(() => _isFollowing = true);
          }
        }
      });

      setState(() {
        _user = User.fromJson(userJson);
        _userAvatarUrl = _usersApi.userAvatarUrl(_user.id!);
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    var ui = _loading
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 20.0),
                CircularProgressIndicator.adaptive(),
              ],
            ),
          )
        : ListTile(
            title: Text(_user.name),
            subtitle: Text(_user.email!),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(_userAvatarUrl),
              foregroundColor: Colors.grey.shade200,
              backgroundColor: Colors.transparent,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.userId == '')
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                if (widget.userId == '')
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                if (widget.userId != '')
                  FollowButton(
                    followed: _user,
                    afterFollowCallback: () =>
                        setState(() => _isFollowing = !_isFollowing),
                    isFollowing: _isFollowing,
                  ),
              ],
            ),
          );
    return ui;
  }
}
