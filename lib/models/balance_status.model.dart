import 'package:flutter/cupertino.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';

import '../constants.dart' as Constants;
import '../utils/currency.util.dart';

class BalanceStatus with ChangeNotifier {
  String _unspentPmob;
  String _displayMob;
  String _dollars;

  BalanceStatus(this._unspentPmob, this._displayMob, this._dollars);

  BalanceStatus.init() : this('0.0000', '0.0000', '0');

  String get dollars => _dollars;

  setDollarAmount(String dollarAmount) {
    _dollars = dollarAmount;
    notifyListeners();
  }

  String get displayMob => _displayMob;

  setDisplayMob(String displayMob) {
    _displayMob = displayMob;
    notifyListeners();
  }

  String get unspentPmob => _unspentPmob;

  setUnspentMob(String unspentPmob) {
    _unspentPmob = unspentPmob;
    notifyListeners();
  }

  add(String amount, CurrencyDisplay display, double mobPrice) {
    if (display.currency == Constants.usd) {
      if (dollars.contains('.')) {
        var index = dollars.indexOf('.');
        if (dollars.length - index < 3) {
          String newAmount = dollars + amount;
          setDollarAmount(newAmount);
          setUnspentMob(convertDollarsToPmob(newAmount, mobPrice));
        }
      } else if (dollars == '0') {
        setDollarAmount(amount);
        setUnspentMob(convertDollarsToPmob(amount, mobPrice));
      } else if (dollars.length > 0) {
        String newAmount = dollars + amount;
        setDollarAmount(newAmount);
        setUnspentMob(convertDollarsToPmob(newAmount, mobPrice));
      }
    } else if (display.currency == Constants.mob) {
      if (unspentPmob == '0.0000') {
        setDollarAmount(convertPmobToDollars(amount, mobPrice));
        setUnspentMob(amount);
      } else if (unspentPmob.contains('.')) {
        var index = unspentPmob.indexOf('.');
        if (unspentPmob.length - index < 5) {
          String newAmount = unspentPmob + amount;
          setDollarAmount(convertPmobToDollars(newAmount, mobPrice));
          setUnspentMob(newAmount);
        }
      } else if (unspentPmob.length > 0) {
        String newAmount = unspentPmob + amount;
        setDollarAmount(convertPmobToDollars(newAmount, mobPrice));
        setUnspentMob(newAmount);
      }
    }
  }

  remove(double mobPrice, CurrencyDisplay display) {
    if (display.currency == Constants.usd) {
      if (dollars.length > 1) {
        String newDollars = dollars.substring(0, dollars.length - 1);
        setDollarAmount(newDollars);
        setUnspentMob(convertDollarsToPmob(newDollars, mobPrice));
      } else {
        setDollarAmount('0');
        setUnspentMob('0.0000');
      }
    } else if (display.currency == Constants.mob) {
      if (unspentPmob.length > 1) {
        String newPmob = unspentPmob.substring(0, unspentPmob.length - 1);
        setDollarAmount(convertPmobToDollars(newPmob, mobPrice));
        setUnspentMob(newPmob);
      } else {
        setDollarAmount('0');
        setUnspentMob('0.0000');
      }
    }
  }
}
