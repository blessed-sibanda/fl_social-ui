import 'package:flutter_social/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthApi extends BaseApi {
  Future<dynamic> signIn(String email, String password) async {
    var response = await http.post(
      Uri.parse('$baseUrl/auth/signin'),
      body: {
        'email': email,
        'password': password,
      },
    );
    return jsonResponse(response);
  }
}
