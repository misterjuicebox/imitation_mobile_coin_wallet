import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_models/send_transaction.dart';
import '../widgets/contact_row_item.dart';
import '../widgets/line.dart';

class ReviewTransaction extends StatelessWidget {
  const ReviewTransaction();

  void toEnterAmount(BuildContext context) {
    Navigator.pushNamed(context, '/enter_amount');
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
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
              toEnterAmount(context);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Review Transaction',
                style: TextStyle(fontSize: 30),
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
                      children: [Text('Amount'), Text('\$' + sendTransaction.balanceStatus.dollars)],
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
                            Text(
                              '0.0004',
                              style: TextStyle(color: Colors.white24),
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
                            Text(
                              sendTransaction.balanceStatus.unspentPmob,
                              style: TextStyle(color: Colors.white24),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        )
      ],
    ));
  }
}
