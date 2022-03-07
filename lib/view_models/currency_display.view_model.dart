import 'package:flutter/foundation.dart';

class CurrencyDisplay with ChangeNotifier {
  String _currency;

  CurrencyDisplay(this._currency);

  String get currency => _currency;

  setCurrencyDisplay(String value) {
    _currency = value;
    notifyListeners();
  }
}
