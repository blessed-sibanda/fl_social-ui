import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;

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

    notifyListeners();
  }
}
