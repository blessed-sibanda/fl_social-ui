import 'package:flutter/cupertino.dart';

class AuthPageProvider extends ChangeNotifier {
  bool _onSignInPage = true;

  bool get onSignInPage => _onSignInPage;

  void goToSignUp() {
    _onSignInPage = false;
    notifyListeners();
  }

  void goToSignIn() {
    _onSignInPage = true;
    notifyListeners();
  }
}
