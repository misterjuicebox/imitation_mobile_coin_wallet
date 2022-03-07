import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imitation_mob_wallet/view_models/balance_status.view_model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.view_model.dart';

import '../constants.dart' as Constants;

class PrimaryAmount extends StatelessWidget {
  final CurrencyDisplay display;
  final BalanceStatus balanceStatus;

  const PrimaryAmount(this.display, this.balanceStatus);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: EdgeInsets.only(right: 5),
        child: display.currency == Constants.mob
            ? SvgPicture.asset(
                'assets/mob_icon.svg',
                color: Colors.white,
                height: 28,
                width: 28,
                semanticsLabel: "Mobile Coin Icon",
              )
            : Text('\$', style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      Text(
        display.currency == Constants.usd
            ? (balanceStatus.dollars == '0' ? "0" : balanceStatus.dollars)
            : (balanceStatus.displayMob == '0.0000' ? "0" : balanceStatus.displayMob),
        style: TextStyle(color: Colors.white, fontSize: 30),
      )
    ]);
  }
}
