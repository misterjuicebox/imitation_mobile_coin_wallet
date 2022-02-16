import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/imitation.view_model.dart';
import '../widgets/currency_toggle.dart';
import '../widgets/info_box.dart';
import '../widgets/line.dart';
import '../widgets/no_data.dart';
import '../widgets/primary_total.dart';
import '../widgets/secondary_total.dart';
import '../widgets/send_receive_row.dart';
import '../widgets/transaction_list.dart';

class BalanceAndTransactions extends StatelessWidget {
  const BalanceAndTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imitation = Provider.of<Imitation>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 60, 10, 15),
            child: Icon(Icons.menu),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: PrimaryTotal(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [SecondaryTotal(), CurrencyToggle()],
            ),
          ),
          Line(color: Colors.white70),
          !imitation.dataLoaded
              ? NoData()
              : Container(
                  height: MediaQuery.of(context).size.height * .65,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          InfoBox(),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 0, 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Activity',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TransactionList(),
                        ],
                      ),
                    ),
                  ),
                ),
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
