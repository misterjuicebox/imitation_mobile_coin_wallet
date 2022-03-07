import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/view_models/balance_status.view_model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.view_model.dart';
import 'package:provider/provider.dart';

import './primary_amount.dart';
import '../view_models/imitation.view_model.dart';

class PrimaryTotal extends StatelessWidget {
  const PrimaryTotal();

  @override
  Widget build(BuildContext context) {
    final CurrencyDisplay display = Provider.of<CurrencyDisplay>(context);
    final BalanceStatus balanceStatus = Provider.of<Imitation>(context).balanceStatus;

    return PrimaryAmount(display, balanceStatus);
  }
}
