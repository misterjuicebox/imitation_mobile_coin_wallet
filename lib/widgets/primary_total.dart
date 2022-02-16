import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../view_models/imitation.view_model.dart';

class PrimaryTotal extends StatelessWidget {
  const PrimaryTotal();

  @override
  Widget build(BuildContext context) {
    return Consumer<Imitation>(builder: (context, imitation, child) {
      return Row(children: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: imitation.currencyDisplay.currency == Constants.mob
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
          imitation.currencyDisplay.currency == Constants.usd
              ? imitation.balanceStatus.dollars
              : imitation.balanceStatus.unspentPmob,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ]);
    });
  }
}
