class User {
  String? id;
  String name;
  String email;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
