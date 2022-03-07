import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/widgets/secondary_amount.dart';
import 'package:provider/provider.dart';

import '../view_models/balance_status.view_model.dart';
import '../view_models/currency_display.view_model.dart';
import '../view_models/imitation.view_model.dart';

class SecondaryTotal extends StatelessWidget {
  const SecondaryTotal();

  @override
  Widget build(BuildContext context) {
    final CurrencyDisplay display = Provider.of<CurrencyDisplay>(context);
    final BalanceStatus balanceStatus = Provider.of<Imitation>(context).balanceStatus;

    return SecondaryAmount(display, balanceStatus);
  }
}
