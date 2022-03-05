import 'package:flutter/material.dart';

import './contact_icon.dart';
import '../models/verifying_transaction.model.dart';
import '../utils/currency.util.dart' as CurrencyUtil;
import '../utils/date.util.dart';

class TransactionVerifyingRowItem extends StatelessWidget {
  final VerifyingTransaction verifyingTransaction;
  const TransactionVerifyingRowItem({required this.verifyingTransaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ContactIcon(contact: verifyingTransaction.contact),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${verifyingTransaction.contact.firstName} ${verifyingTransaction.contact.lastName}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Text('Sent  -  Verifying...', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "- " + CurrencyUtil.convertToDisplayMob(verifyingTransaction.pmob) + ' MOB',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: .1),
              ),
              Container(
                child: Text(
                  DateUtil.cleanAndConvert(verifyingTransaction.sentTime),
                  style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: .6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
