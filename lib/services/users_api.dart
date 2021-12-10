import 'package:fl_social/models/user.dart';
import 'package:fl_social/services/base_api.dart';

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

  Future<dynamic> updateUser(User user, String? imagePath) async {
    var url = Uri.parse('$baseUrl/api/signup');
    var request = http.MultipartRequest('PUT', url);
    request.fields['user[name]'] = user.name;
    request.fields['user[email]'] = user.email!;
    request.fields['user[about]'] = user.about ?? '';
    request.fields['user[current_password]'] = user.currentPassword!;
    if (user.password != null) {
      request.fields['user[password]'] = user.password!;
    }
    if (imagePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'user[avatar_image]',
          imagePath,
        ),
      );
    }
    request.headers['Authorization'] = await authToken;
    request.headers['Accept'] = "*/*";
    var response = await request.send();
    if (response.statusCode == 422 || response.statusCode==400) {
      return ServiceApiError(await response.stream.bytesToString(), 422);
    }
    return response;
  }

  Future<List<dynamic>> findUsers() async {
    var response = await http.get(
      Uri.parse('$baseUrl/users/find_people.json'),
      headers: {
        'Authorization': await authToken,
        'Accept': '*/*',
      },
    );

    return json.decode(response.body)['data'];
  }

  Future<void> followUser(int followId) async {
    await http.put(Uri.parse('$baseUrl/users/$followId/follow'), headers: {
      'Authorization': await authToken,
    });
  }

  Future<void> unfollowUser(int unfollowId) async {
    await http.put(
      Uri.parse('$baseUrl/users/$unfollowId/unfollow'),
      headers: {
        'Authorization': await authToken,
      },
    );
  }

  Future<dynamic> getUser([int userId = -1]) async {
    var response = await http.get(
      Uri.parse(userId == -1 ? '$baseUrl/users/me' : '$baseUrl/users/$userId'),
      headers: {
        'Authorization': await authToken,
        "Accept": "*/*",
      },
    );

    return jsonDecode(response.body);
  }
}
