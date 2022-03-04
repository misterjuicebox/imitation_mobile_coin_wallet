import 'package:flutter/cupertino.dart';

class SendAmount with ChangeNotifier {
  String _dollarAmount;

  SendAmount(this._dollarAmount);

  String get dollarAmount => _dollarAmount;

  setDollarAmount(String dollarAmount) {
    _dollarAmount = dollarAmount;
    notifyListeners();
  }
}
