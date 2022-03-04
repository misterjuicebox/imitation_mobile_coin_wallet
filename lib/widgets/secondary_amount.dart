import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart' as Constants;
import '../models/balance_status.model.dart';
import '../view_models/currency_display.model.dart';

class SecondaryAmount extends StatelessWidget {
  final CurrencyDisplay display;
  final BalanceStatus balanceStatus;

  const SecondaryAmount(this.display, this.balanceStatus);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      display.currency == Constants.usd
          ? SvgPicture.asset(
              'assets/mob_icon.svg',
              color: Colors.white54,
              height: 15,
              width: 15,
              semanticsLabel: 'Mobile Coin Icon',
            )
          : Text('\$', style: TextStyle(color: Colors.white54, fontSize: 14)),
      Padding(
          padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
          child: Text(
            display.currency == Constants.mob
                ? (balanceStatus.dollars == '0' ? "0.00" : balanceStatus.dollars)
                : (balanceStatus.unspentPmob == '0.0000' ? "0.0000" : balanceStatus.unspentPmob),
            style: TextStyle(color: Colors.white54, fontSize: 14),
          )),
    ]);
  }
}
