import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imitation_mob_wallet/models/balance_status.model.dart';
import 'package:imitation_mob_wallet/view_models/currency_display.model.dart';
import 'package:imitation_mob_wallet/view_models/send_transaction.dart';
import 'package:imitation_mob_wallet/widgets/contact_row_item.dart';
import 'package:imitation_mob_wallet/widgets/currency_toggle.dart';
import 'package:imitation_mob_wallet/widgets/line.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart' as Constants;
import '../utils/currency.util.dart';
import '../view_models/imitation.view_model.dart';
import '../widgets/amount_button.dart';
import '../widgets/error_dialog.dart';
import '../widgets/primary_send_amount.dart';
import '../widgets/secondary_amount.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({Key? key}) : super(key: key);

  @override
  _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  void toSend(BuildContext context) {
    Navigator.pushNamed(context, '/send');
  }

  void goToReview(BuildContext context) {
    Navigator.pushNamed(context, '/review_transaction');
  }

  @override
  Widget build(BuildContext context) {
    final CurrencyDisplay currencyDisplay = Provider.of<CurrencyDisplay>(context);
    final BalanceStatus balanceStatus = Provider.of<Imitation>(context).balanceStatus;
    final BalanceStatus sendBalanceStatus = Provider.of<BalanceStatus>(context);
    final double? mobPrice = Provider.of<Imitation>(context).mobPrice?.data.the7878.quote.usd.price;
    final SendTransaction sendTransaction = Provider.of<SendTransaction>(context);

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.white,
              size: 23.0,
            ),
            onPressed: () {
              toSend(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Amount',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
          child: ContactRowItem(contact: sendTransaction.contact),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 15),
          child: PrimarySendAmount(currencyDisplay, sendBalanceStatus),
        ),
        Line(color: Colors.white54),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SecondaryAmount(currencyDisplay, sendBalanceStatus), CurrencyToggle()],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SecondaryAmount(CurrencyDisplay(Constants.mob), balanceStatus),
              ),
              Container(
                height: 13,
                decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.white54, width: 1, style: BorderStyle.solid))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SecondaryAmount(CurrencyDisplay(Constants.usd), balanceStatus),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AmountButton('1'),
                    AmountButton('2'),
                    AmountButton('3'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AmountButton('4'),
                    AmountButton('5'),
                    AmountButton('6'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AmountButton('7'),
                    AmountButton('8'),
                    AmountButton('9'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AmountButton('.'),
                    AmountButton('0'),
                    GestureDetector(
                      child: Text('x', style: TextStyle(fontSize: 35)),
                      onTap: () => currencyDisplay.currency == Constants.usd
                          ? sendBalanceStatus.removeUsd(mobPrice!)
                          : sendBalanceStatus.removeMob(mobPrice!),
                    ),
                  ],
                )
              ]),
              height: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.5), borderRadius: BorderRadius.circular(10))),
        ),
        Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          width: MediaQuery.of(context).size.width * 50,
          child: OutlineGradientButton(
            padding: EdgeInsets.fromLTRB(59, 15, 59, 15),
            child: const Text(
              'Review',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            gradient: LinearGradient(colors: [Colors.white, Colors.teal]),
            strokeWidth: 2,
            radius: Radius.circular(8),
            onTap: () {
              if (validateAmount(sendBalanceStatus, balanceStatus)) {
                sendTransaction.setBalanceStatus(sendBalanceStatus);
                goToReview(context);
              } else {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext builder) {
                      return ErrorDialog(errorMessage: 'Not enough funds in your wallet.');
                    });
              }
            },
          ),
        )
      ],
    ));
  }

  bool validateAmount(BalanceStatus sendBalanceStatus, BalanceStatus balanceStatus) {
    if (double.parse(addFee(sendBalanceStatus.unspentPmob)) <= double.parse(balanceStatus.unspentPmob)) {
      return true;
    } else {
      return false;
    }
  }
}
