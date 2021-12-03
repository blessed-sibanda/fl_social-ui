import 'package:flutter_social/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersApi {
  final String baseUrl = 'http://192.168.43.72:3000/api';

  Future<dynamic> createUser(User user) async {
    var response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: user.toJson(),
    );

    var jsonResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      return jsonResponse['message'];
    } else {
      return ServiceApiError(jsonResponse['error'], response.statusCode);
    }
  }
}

class ServiceApiError {
  final String message;
  final int code;
  ServiceApiError(this.message, this.code);
}
