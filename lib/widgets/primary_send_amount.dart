import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imitation_mob_wallet/models/balance_status.model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';

import '../constants.dart' as Constants;

class PrimarySendAmount extends StatelessWidget {
  final CurrencyDisplay display;
  final BalanceStatus balanceStatus;

  const PrimarySendAmount(this.display, this.balanceStatus);

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
      Row(
        children: [
          Text(
            display.currency == Constants.usd
                ? (balanceStatus.dollars == '0' ? "0" : balanceStatus.dollars)
                : (balanceStatus.displayMob == '0.0000' ? "0" : balanceStatus.displayMob),
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          placeHolder(display.currency, balanceStatus)
        ],
      ),
    ]);
  }

  Widget placeHolder(String currency, BalanceStatus balanceStatus) {
    if (display.currency == Constants.usd) {
      if (balanceStatus.dollars.contains('.') &&
          balanceStatus.dollars.length - balanceStatus.dollars.indexOf('.') < 2) {
        return Text('00', style: TextStyle(fontSize: 30, color: Colors.white24));
      } else if (balanceStatus.dollars.contains('.') &&
          balanceStatus.dollars.length - balanceStatus.dollars.indexOf('.') < 3) {
        return Text('0', style: TextStyle(fontSize: 30, color: Colors.white24));
      }
    } else if (display.currency == Constants.mob) {
      if (balanceStatus.displayMob.contains('.') &&
          balanceStatus.displayMob.length - balanceStatus.displayMob.indexOf('.') < 2) {
        return Text('0000', style: TextStyle(fontSize: 30, color: Colors.white24));
      } else if (balanceStatus.displayMob.contains('.') &&
          balanceStatus.displayMob.length - balanceStatus.displayMob.indexOf('.') < 3) {
        return Text('000', style: TextStyle(fontSize: 30, color: Colors.white24));
      } else if (balanceStatus.displayMob.contains('.') &&
          balanceStatus.displayMob.length - balanceStatus.displayMob.indexOf('.') < 4) {
        return Text('00', style: TextStyle(fontSize: 30, color: Colors.white24));
      } else if (balanceStatus.displayMob.contains('.') &&
          balanceStatus.displayMob.length - balanceStatus.displayMob.indexOf('.') < 5) {
        return Text('0', style: TextStyle(fontSize: 30, color: Colors.white24));
      }
    }

    return Text('');
  }
}
