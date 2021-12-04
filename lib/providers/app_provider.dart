import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_social/utils/app_cache.dart';

class AppProvider extends ChangeNotifier {
  final _appCache = AppCache();

  bool _initialized = false;
  bool _loggedIn = false;
  bool _didSelectUser = false;
  bool _onPeople = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;

  bool get didSelectUser => _didSelectUser;
  bool get onPeople => _onPeople;

  void _reset() {
    _didSelectUser = false;
    _onPeople = false;
  }

  void initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void logIn(Map<String, dynamic> userData) async {
    await _appCache.cacheUserData(userData);
    _loggedIn = true;
    notifyListeners();
  }

  void logOut() async {
    _loggedIn = false;
    _reset();
    await _appCache.invalidate();

    notifyListeners();
  }

  void goToHome() {
    _reset();
    notifyListeners();
  }

  void goToProfile() {
    _reset();
    _didSelectUser = true;
    notifyListeners();
  }

  void goToPeople() {
    _reset();
    _onPeople = true;
    notifyListeners();
  }
}
