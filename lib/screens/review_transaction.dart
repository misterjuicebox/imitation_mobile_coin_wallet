import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imitation_mob_wallet/view_models/imitation.view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/build_and_submit_transaction_response.dart';
import '../services/api.service.dart';
import '../services/transaction.service.dart';
import '../utils/currency.util.dart';
import '../view_models/send_transaction.dart';
import '../widgets/contact_row_item.dart';
import '../widgets/error_dialog.dart';
import '../widgets/line.dart';
import '../widgets/slider_button.dart';

class ReviewTransaction extends StatelessWidget {
  const ReviewTransaction();

  void toHome(BuildContext context) {
    Navigator.pushNamed(context, '/');
  }

  void toEnterAmount(BuildContext context) {
    Navigator.pushNamed(context, '/enter_amount');
  }

  void toSending(BuildContext context) {
    Navigator.pushNamed(context, '/sending');
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    final SendTransaction sendTransaction = Provider.of<SendTransaction>(context);
    final Imitation imitation = Provider.of<Imitation>(context, listen: false);

    String mobTotal = convertToDisplayMob(addFee(sendTransaction.balanceStatus.unspentPmob));
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 15),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.white,
              size: 23.0,
            ),
            onPressed: () {
              toEnterAmount(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Review Transaction',
                style: TextStyle(fontSize: 35),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Consumer<SendTransaction>(builder: (context, transaction, child) {
            return ContactRowItem(contact: transaction.contact);
          }),
        ),
        Line(color: Colors.white24),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
          child: Container(
              // height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white24, width: 1)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Time'),
                        Text(DateFormat('MMM dd, y').format(dateTime) +
                            " at " +
                            DateFormat('h:mm:ss a').format(dateTime))
                      ],
                    ),
                  ),
                  Line(color: Colors.white24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount'),
                        Text(
                          '\$' + sendTransaction.balanceStatus.dollars,
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  Line(color: Colors.white24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transaction fee'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$0.00'),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/mob_icon.svg',
                                    color: Colors.white24,
                                    height: 14,
                                    width: 14,
                                    semanticsLabel: "Mobile Coin Icon",
                                  ),
                                  Text(
                                    ' 0.0004',
                                    style: TextStyle(color: Colors.white24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Line(color: Colors.white24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total amount'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                '\$' + sendTransaction.balanceStatus.dollars,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/mob_icon.svg',
                                    color: Colors.white24,
                                    height: 16,
                                    width: 16,
                                    semanticsLabel: "Mobile Coin Icon",
                                  ),
                                  Text(
                                    " " + mobTotal,
                                    style: TextStyle(color: Colors.white24),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 170, 4, 10),
          child: Container(
              height: 50,
              width: 358,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 1.5)),
              child: SliderButton(
                action: () async {
                  // // todo do i need this?
                  toSending(context);
                  // String pmobToSend = TransactionUtil.getRandomPmob();
                  final ApiService submitTransactionResponse =
                      await TransactionService().buildAndSubmitTransaction(sendTransaction);
                  if (submitTransactionResponse.response != null) {
                    imitation.buildAndSetVerifyingTransaction(
                        submitTransactionResponse.response as BuildAndSubmitTransactionResponse);
                    toHome(context);
                  } else {
                    toHome(context);
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext builder) {
                          return ErrorDialog(errorMessage: submitTransactionResponse.errorResponse!);
                        });
                    Future.delayed(Duration(seconds: 5), () => toHome(context));
                  }
                },
                label: Text(
                  'Slide to Pay',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                icon: Center(
                    child: Icon(
                  CupertinoIcons.arrow_right,
                  color: Colors.black,
                  size: 13.0,
                )),
                buttonSize: 46.5,
                alignLabel: Alignment(.01, 0),
                width: 370,
                radius: 8,
                buttonColor: Colors.white,
                backgroundColor: Color(0xff191919),
                highlightedColor: Colors.white,
                baseColor: Colors.grey,
                boxShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
                dismissThresholds: .85,
              )),
        ),
      ],
    ));
  }
}
