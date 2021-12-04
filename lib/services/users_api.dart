import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/services/base_api.dart';
import 'package:flutter_social/utils/app_cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersApi extends BaseApi {
  Future<dynamic> createUser(User user) async {
    var response = await http.post(
      Uri.parse('$baseUrl/api/users'),
      body: user.toJson(),
    );
    return jsonResponse(response, dataKey: 'message');
  }

  Future<List<dynamic>> findUsers() async {
    User currentUser = await AppCache().currentUser();

    var response = await http.get(
      Uri.parse('$baseUrl/api/users/findpeople/${currentUser.id}'),
      headers: {
        'Authorization': 'Bearer ${currentUser.token}',
      },
    );
    print(response.body);
    // print(jsonResponse(response));
    // return jsonResponse(response);
    return json.decode(response.body);
  }
}
