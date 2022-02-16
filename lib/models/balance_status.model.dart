import 'package:flutter/foundation.dart';

class BalanceStatus with ChangeNotifier {
  final String unspentPmob;
  final String? displayMob;
  final String dollars;
  String? accountBlockHeight;

  BalanceStatus({required this.unspentPmob, required this.displayMob, required this.dollars, this.accountBlockHeight});

  Map toJson() => {
        'unspentPmob': unspentPmob,
        'displayMob': displayMob,
        'accountBlockHeight': accountBlockHeight,
      };

  BalanceStatus.fromJson(Map<String, dynamic> json)
      : unspentPmob = json['unspentPmob'],
        displayMob = json['displayMob'],
        dollars = json['dollars'],
        accountBlockHeight = json['accountBlockHeight'];
}
