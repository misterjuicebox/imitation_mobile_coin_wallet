import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/view_models/pin_display.dart';
import 'package:provider/provider.dart';

import '../widgets/currency_toggle.dart';
import '../widgets/line.dart';
import '../widgets/primary_total.dart';
import '../widgets/secondary_total.dart';
import '../widgets/send_receive_row.dart';
import '../widgets/transaction_scroll.dart';

class BalanceAndTransactions extends StatelessWidget {
  const BalanceAndTransactions();

  @override
  Widget build(BuildContext context) {
    final PinDisplay pinDisplay = Provider.of<PinDisplay>(context);
    if (pinDisplay.navigate) pinDisplay.setNavigate(false);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 60, 10, 15),
            child: Icon(Icons.menu),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const PrimaryTotal(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const SecondaryTotal(), CurrencyToggle()],
            ),
          ),
          const Line(color: Colors.white70),
          const TransactionScroll(),
          Line(color: Colors.white70),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: const SendReceiveRow(),
          )
        ],
      ),
    );
  }
}
