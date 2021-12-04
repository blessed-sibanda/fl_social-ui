class User {
  String? id;
  String name;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'] as String?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] as DateTime?,
      updatedAt: json['updatedAt'] as DateTime?,
    );
  }

  Map<String, dynamic> toJson() {
    var userMap = {
      'name': name,
      'email': email,
      'password': password,
    };
    if (id != null) userMap['id'] = id;
    return userMap;
  }
}
