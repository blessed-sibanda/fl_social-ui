import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static const kUserToken = 'user';

  Future<void> cacheUserToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kUserToken, value);
  }

  Future<void> invalidate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kUserToken);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(kUserToken);
  }

  Future<String> userToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserToken) ?? '';
  }
}
