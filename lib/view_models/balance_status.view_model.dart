import 'package:flutter/cupertino.dart';

import '../utils/currency.util.dart';

class BalanceStatus with ChangeNotifier {
  String _unspentPmob;
  String _displayMob;
  String _dollars;

  BalanceStatus(this._unspentPmob, this._displayMob, this._dollars);

  BalanceStatus.init() : this('0', '0.0000', '0');

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

  // todo clean up and optimize
  void addMob(String entry, double mobPrice) {
    if (displayMob == '0.0000' || displayMob == '0') {
      if (!entry.contains('.')) {
        String newDisplayMob = double.parse(entry).toStringAsFixed(4);
        setBalanceToSend(convertDisplayMobToDollars(newDisplayMob, mobPrice), entry);
      } else {
        setBalanceToSend('0', '0.');
      }
    } else if (displayMob.contains('.')) {
      if (displayMob.length - displayMob.indexOf('.') < 5) {
        String displayMobTotal = displayMob + entry;
        String dollarSum = convertDisplayMobToDollars(displayMobTotal, mobPrice);
        setBalanceToSend(dollarSum, displayMobTotal);
      }
    } else {
      String displayMobTotal = displayMob + entry;
      String dollarSum = convertDisplayMobToDollars(displayMobTotal, mobPrice);
      setBalanceToSend(dollarSum, displayMobTotal);
    }
  }

  void addUsd(String entry, double mobPrice) {
    String currentDollars = dollars;
    String dollarTotal = currentDollars + entry;
    String displayMobEntrySum = convertDollarsToDisplayMob(dollarTotal, mobPrice);

    if (currentDollars.contains('.')) {
      if (currentDollars.length - dollars.indexOf('.') < 3) {
        setBalanceToSend(dollarTotal, displayMobEntrySum);
      }
    } else if (currentDollars == '0') {
      if (!entry.contains('.')) {
        String displayMob = convertDollarsToDisplayMob(entry, mobPrice);
        setBalanceToSend(entry, displayMob);
      } else {
        setBalanceToSend(entry, '0.0000');
      }
    } else if (currentDollars.length > 0) {
      setBalanceToSend(dollarTotal, displayMobEntrySum);
    }
  }

  void setBalanceToSend(String dollars, String displayMob) {
    setDollarAmount(dollars);
    setDisplayMob(displayMob);
    setUnspentMob(convertToPmob(displayMob));
  }

  void removeUsd(double mobPrice) {
    if (dollars == '0') {
      return;
    }
    if (dollars.length > 1) {
      String newDollars = dollars.substring(0, dollars.length - 1);
      if (newDollars == '.') {
        setBalanceToSend('0', '0.0000');
      } else {
        setBalanceToSend(newDollars, convertDollarsToDisplayMob(newDollars, mobPrice));
      }
    } else {
      setBalanceToSend('0', '0.0000');
    }
  }

  void removeMob(double mobPrice) {
    if (displayMob.length > 1) {
      String newDisplayMob = displayMob.substring(0, displayMob.length - 1);
      if (newDisplayMob == '0.') {
        setBalanceToSend("0", '0.0000');
      } else {
        setBalanceToSend(convertDisplayMobToDollars(newDisplayMob, mobPrice), newDisplayMob);
      }
    } else {
      setBalanceToSend('0', '0.0000');
    }
  }
}
