import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../view_models/imitation.view_model.dart';

class PrimaryTotal extends StatelessWidget {
  const PrimaryTotal();

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyDisplay>(builder: (context, currency, child) {
      return Row(children: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: currency.currency == Constants.mob
              ? SvgPicture.asset(
                  'assets/mob_icon.svg',
                  color: Colors.white,
                  height: 28,
                  width: 28,
                  semanticsLabel: "Mobile Coin Icon",
                )
              : Text('\$', style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        Consumer<Imitation>(builder: (context, imitation, child) {
          return Text(
            currency.currency == Constants.usd ? imitation.balanceStatus.dollars : imitation.balanceStatus.unspentPmob,
            style: TextStyle(color: Colors.white, fontSize: 30),
          );
        })
      ]);
    });
  }
}
