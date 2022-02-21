import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../view_models/currency_display.model.dart';
import '../view_models/imitation.view_model.dart';

class SecondaryTotal extends StatelessWidget {
  const SecondaryTotal();

  @override
  Widget build(BuildContext context) {
    final imitation = Provider.of<Imitation>(context);
    final currency = Provider.of<CurrencyDisplay>(context);
    return Row(children: [
      currency.currency == Constants.usd
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
          currency.currency == Constants.mob ? imitation.balanceStatus.dollars : imitation.balanceStatus.unspentPmob,
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ),
    ]);
  }
}
