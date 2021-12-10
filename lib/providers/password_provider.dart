import 'package:flutter/cupertino.dart';

class PasswordProvider extends ChangeNotifier {
  bool _valid = true;

  bool get isInvalid => !_valid;

  void invalidate() {
    _valid = false;
    notifyListeners();
  }

  void validate() {
    _valid = true;
    notifyListeners();
  }
}
