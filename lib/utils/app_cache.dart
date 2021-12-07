import 'package:fl_social/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUserToken = 'userToken';
  static const kUserId = 'userId';
  static const kUserName = 'userName';
  static const kUserEmail = 'userEmail';

  Future<void> cacheUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserToken, userData['token']);
    await prefs.setString(kUserId, userData['user']['_id']);
    await prefs.setString(kUserName, userData['user']['name']);
    await prefs.setString(kUserEmail, userData['user']['email']);
  }

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserToken);
    await prefs.remove(kUserId);
    await prefs.remove(kUserName);
    await prefs.remove(kUserEmail);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(kUserToken);
  }

  Future<User> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User(
      token: prefs.getString(kUserToken)!,
      id: prefs.getString(kUserId)!,
      name: prefs.getString(kUserName)!,
      email: prefs.getString(kUserEmail)!,
    );
  }
}
