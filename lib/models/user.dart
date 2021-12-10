import 'package:intl/intl.dart';

class User {
  int? id;
  String name;
  String? email;
  String? password;
  DateTime? createdAt;
  List<User>? followers;
  List<User>? following;
  String? about;
  String? currentPassword;
  String? avatarUrl;

  User({
    this.id,
    required this.name,
    this.email,
    this.password,
    this.createdAt,
    this.followers,
    this.following,
    this.about,
    this.currentPassword,
    this.avatarUrl,
  }) {
    followers ??= [];
    following ??= [];
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final followers = <User>[];
    final following = <User>[];
    if (json.containsKey('followers')) {
      for (final userJson in json['followers']['data']) {
        followers.add(User.fromJson(userJson));
      }
    }
    if (json.containsKey('following')) {
      for (final userJson in json['following']['data']) {
        following.add(User.fromJson(userJson));
      }
    }

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'] as String?,
      password: json['password'] as String?,
      about: json['about'] as String?,
      createdAt: json.containsKey('created_at')
          ? DateTime.parse(json['created_at'])
          : null,
      followers: followers,
      following: following,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    var userMap = {
      'name': name,
      'email': email,
      'about': about,
    };
    if (password != null) userMap['password'] = password;
    if (id != null) userMap['id'] = id as String?;
    if (currentPassword != null) userMap['current_password'] = currentPassword;
    return userMap;
  }

  String get joinedAt {
    if (createdAt != null) {
      DateTime localCreated = createdAt!.toLocal();
      return '${DateFormat.yMMMd().format(localCreated)} - ${DateFormat.Hm().format(localCreated)}';
    }
    return '';
  }
}
