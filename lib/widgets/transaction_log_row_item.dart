import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/widgets/transaction_id_icon.dart';

import './transaction_id_icon.dart';
import '../models/transaction_log.model.dart';
import '../utils/currency.util.dart' as CurrencyUtil;
import '../utils/date.util.dart';

class TransactionLogRowItem extends StatelessWidget {
  final Transaction transaction;
  TransactionLogRowItem({required this.transaction});

  // This technique below could be used if TransactionLobRowItem needed to make a call to manipulate
  // an field in Transaction, like if we wanted to mark transaction as a favorite, or no longer show it in the list

  // TransactionLogRowItem();

  @override
  Widget build(BuildContext context) {
    // This technique below could be used if TransactionLobRowItem needed to make a call to manipulate
    // an field in Transaction, like if we wanted to mark transaction as a favorite, or no longer show it in the list

    // final transaction = Provider.of<Transaction>(context);
    return AnimatedContainer(
        duration: transaction.confirm ? Duration(seconds: 0) : Duration(seconds: 2),
        height: 50,
        color: transaction.confirm ? Colors.green.withOpacity(.16) : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TransactionIdIcon(transactionId: transaction.id),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text(StringUtils.addCharAtPosition(transaction.id.substring(0, 8), '-', 4),
                    style:
                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: .4)),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text(
                      CurrencyUtil.convertAndTotalMob(transaction) + ' MOB',
                      style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: .1),
                    ),
                  ),
                  Text(
                    DateUtil.cleanAndConvert(transaction.sentTime),
                    style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: .6),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
