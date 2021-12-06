import 'package:intl/intl.dart';

class User {
  String? id;
  String name;
  String? email;
  String? password;
  DateTime? createdAt;
  String? token;
  List<User>? followers;
  List<User>? following;
  String? about;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
    this.token,
    this.followers,
    this.following,
    this.about,
  }) {
    followers ??= [];
    following ??= [];
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final followers = <User>[];
    final following = <User>[];
    if (json.containsKey('followers')) {
      for (final userJson in json['followers']) {
        followers.add(User.fromJson(userJson));
      }
    }
    if (json.containsKey('following')) {
      for (final userJson in json['following']) {
        following.add(User.fromJson(userJson));
      }
    }
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'] as String?,
      password: json['password'] as String?,
      about: json['about'] as String?,
      createdAt:
          json.containsKey('created') ? DateTime.parse(json['created']) : null,
      followers: followers,
      following: following,
    );
  }

  Map<String, dynamic> toJson() {
    var userMap = {
      'name': name,
      'email': email,
      // 'password': password,
      // 'about': about,
    };
    if (id != null) userMap['id'] = id;
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
