import 'dart:async';

import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
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
    _reset();

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
