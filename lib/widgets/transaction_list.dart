import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './transaction_log_row_item.dart';
import './transaction_verifying_row_item.dart';
import '../models/transaction_log.model.dart';
import '../models/verifying_transaction.model.dart';
import '../view_models/imitation.view_model.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imitation = Provider.of<Imitation>(context);
    final List<Transaction> transactionLogs = imitation.transactionLogs;
    final List<VerifyingTransaction> verifyingTransactions = imitation.verifyingTransactions;

    return Column(
      children: [
        ...verifyingTransactions.map((vTx) {
          return TransactionVerifyingRowItem(verifyingTransaction: vTx);
        }),
        ...transactionLogs.map((tx) {
          return TransactionLogRowItem(transaction: tx);
          // This technique below could be used if TransactionLobRowItem needed to make a call to manipulate
          // an field in Transaction, like if we wanted to mark transaction as a favorite, or no longer show it in the list
          // return ChangeNotifierProvider.value(value: tx, child: TransactionLogRowItem());
        }),
      ],
    );
  }
}
