import 'package:flutter/material.dart';

class PinDisplay with ChangeNotifier {
  String _pin = '';
  bool _navigate = false;

  String get pin => _pin;

  setPin(String pin) {
    _pin = pin;
    notifyListeners();
  }

  bool get navigate => _navigate;

  setNavigate(bool navigate) {
    _navigate = navigate;
    notifyListeners();
  }

  void addValue(String value) {
    print(value);
    if (pin.length < 6) setPin(pin + value);
    if (pin.length == 6) checkValue();
  }

  void removeValue() {
    if (pin.length > 0) setPin(pin.substring(0, pin.length - 1));
  }

  checkValue() {
    if (pin == '123456')
      setNavigate(true);
    else
      setPin('');
  }
}
