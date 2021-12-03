import 'package:flutter_social/models/user.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  final String baseUrl = 'http://192.168.43.72:3000/api';

  Future<dynamic> createUser(User user) async {
    print('User --> ${user.toJson()}');
    var response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: user.toJson(),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
