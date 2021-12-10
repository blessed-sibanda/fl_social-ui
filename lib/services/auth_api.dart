import 'package:fl_social/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthApi extends BaseApi {
  Future<dynamic> signIn(String email, String password) async {
    var response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      body: {
        'user[email]': email,
        'user[password]': password,
      },
      headers: {
        "Accept": "*/*",
      },
    );

    if (response.statusCode == 401) {
      return ServiceApiError(response.body, response.statusCode);
    } else {
      return response.headers['authorization']!;
    }
  }
}
