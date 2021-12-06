import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/users_api.dart';

class FollowButton extends StatelessWidget {
  final UsersApi _usersApi = UsersApi();

  final User followed;
  final bool isFollowing;
  final Function afterFollowCallback;
  FollowButton({
    Key? key,
    required this.followed,
    required this.afterFollowCallback,
    this.isFollowing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        isFollowing
            ? await _usersApi.unfollowUser(followed.id!)
            : await _usersApi.followUser(followed.id!);

        String innerText =
            isFollowing ? 'have unfollowed' : 'are now following';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You $innerText ${followed.name}')),
        );
        afterFollowCallback.call();
      },
      child: Text(isFollowing ? 'unfollow' : 'Follow'),
    );
  }
}
