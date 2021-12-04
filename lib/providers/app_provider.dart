import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  bool _didSelectUser = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get didSelectUser => _didSelectUser;

  void initializeApp() async {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void logIn() {
    _loggedIn = true;
    notifyListeners();
  }

  void logOut() {
    print('logging Out');
    _loggedIn = false;
    _didSelectUser = false;

    notifyListeners();
  }

  void goToHome() {
    _didSelectUser = false;
    notifyListeners();
  }

  void goToProfile() {
    _didSelectUser = true;
    notifyListeners();
  }
}
