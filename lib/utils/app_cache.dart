import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUserToken = 'userToken';

  Future<void> cacheUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserToken, token);
  }

  Future<String> userToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserToken)!;
  }

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserToken);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(kUserToken);
  }
}
