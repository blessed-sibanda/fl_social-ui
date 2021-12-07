import 'package:flutter/material.dart';
import 'package:fl_social/models/user.dart';
import 'package:fl_social/providers/app_provider.dart';
import 'package:fl_social/services/users_api.dart';
import 'package:fl_social/utils/app_cache.dart';
import 'package:fl_social/widgets/follow_button.dart';
import 'package:provider/provider.dart';

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

  void _loadData() {
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
        : _buildUserInfo(context);
    return ui;
  }

  Column _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
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
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false).editUser();
                  },
                  icon: const Icon(Icons.edit),
                ),
              if (widget.userId == '')
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return _buildConfirmDeleteDialog(context);
                      },
                    );
                  },
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
        ),
        const Divider(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Joined: ${_user.joinedAt}',
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

Widget _buildConfirmDeleteDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Delete Account'),
    content: const Text('Are you sure?'),
    actions: [
      MaterialButton(
        elevation: 1.0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.close, size: 20.0),
            SizedBox(width: 10.0),
            Text('No'),
          ],
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
      ),
      MaterialButton(
        elevation: 1.0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check, size: 20.0),
            SizedBox(width: 10.0),
            Text('Yes'),
          ],
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    ],
  );
}
