import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/view_models/balance_status.view_model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.view_model.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../view_models/imitation.view_model.dart';

class AmountButton extends StatelessWidget {
  final String amount;
  // final BalanceStatus sendBalanceStatus;

  const AmountButton(this.amount);

  @override
  Widget build(BuildContext context) {
    final CurrencyDisplay display = Provider.of<CurrencyDisplay>(context);
    final BalanceStatus sendBalanceStatus = Provider.of<BalanceStatus>(context);
    final double? mobPrice = Provider.of<Imitation>(context).mobPrice?.data.the7878.quote.usd.price;
    return GestureDetector(
      child: Text(amount, style: TextStyle(fontSize: 35)),
      onTap: () => display.currency == Constants.usd
          ? sendBalanceStatus.addUsd(amount, mobPrice!)
          : sendBalanceStatus.addMob(amount, mobPrice!),
    );
  }
}
