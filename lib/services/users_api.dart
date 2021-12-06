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

    return json.decode(response.body);
  }

  String userAvatarUrl(String userId) {
    return '$baseUrl/api/users/photo/$userId';
  }

  Future<dynamic> followUser(String followId) async {
    User currentUser = await AppCache().currentUser();

    var response = await http.put(
      Uri.parse('$baseUrl/api/users/follow'),
      headers: {
        'Authorization': 'Bearer ${currentUser.token}',
      },
      body: {
        'userId': currentUser.id,
        'followId': followId,
      },
    );
    return jsonResponse(response);
  }

  Future<dynamic> unfollowUser(String unfollowId) async {
    User currentUser = await AppCache().currentUser();

    var response = await http.put(
      Uri.parse('$baseUrl/api/users/unfollow'),
      headers: {
        'Authorization': 'Bearer ${currentUser.token}',
      },
      body: {
        'userId': currentUser.id,
        'unfollowId': unfollowId,
      },
    );
    return jsonResponse(response);
  }

  Future<dynamic> getUser(String userId) async {
    User currentUser = await AppCache().currentUser();

    var response = await http.get(
      Uri.parse(
          '$baseUrl/api/users/${userId.isEmpty ? currentUser.id! : userId}'),
      headers: {
        'Authorization': 'Bearer ${currentUser.token}',
      },
    );
    return jsonResponse(response);
  }
}
