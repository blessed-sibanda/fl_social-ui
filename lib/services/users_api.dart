import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/base_api.dart';
import 'package:http/http.dart' as http;

class UsersApi extends BaseApi {
  Future<dynamic> createUser(User user) async {
    var response = await http.post(
      Uri.parse('$baseUrl/api/users'),
      body: user.toJson(),
    );
    return jsonResponse(response, dataKey: 'message');
  }
}
