import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './transaction_log_row_item.dart';
import './transaction_verifying_row_item.dart';
import '../models/transaction_log.model.dart';
import '../models/verifying_transaction.model.dart';
import '../view_models/imitation.view_model.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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
        }),
      ],
    );
  }
}
