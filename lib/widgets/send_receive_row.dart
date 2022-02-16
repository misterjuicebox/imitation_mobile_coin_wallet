import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import '../services/api.service.dart';
import '../services/transaction.service.dart';
import '../utils/transaction.util.dart';
import 'error_dialog.dart';
import 'qr_icon.dart';

class SendReceiveRow extends StatelessWidget {
  const SendReceiveRow();

  void goToSend(BuildContext context) {
    Navigator.pushNamed(context, '/send');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Builder(builder: (context) {
          return OutlineGradientButton(
            padding: EdgeInsets.fromLTRB(59, 15, 59, 15),
            child: const Text(
              'Send',
              style: TextStyle(color: Colors.white),
            ),
            gradient: LinearGradient(colors: [Colors.white, Colors.teal]),
            strokeWidth: 2,
            radius: Radius.circular(8),
            onTap: () {
              goToSend(context);
            },
          );
        }),
        OutlineGradientButton(
          padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
          child: const Text(
            'Receive',
            style: TextStyle(color: Colors.white),
          ),
          gradient: LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
          strokeWidth: 2,
          radius: Radius.circular(8),
          onTap: () async {
            String pmobToSend = TransactionUtil.getRandomPmob();
            final ApiService receiveResponse = await TransactionService().receiveTransaction(pmobToSend);
            if (receiveResponse.errorResponse != null) {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext builder) {
                    return ErrorDialog(errorMessage: receiveResponse.errorResponse!);
                  });
              Future.delayed(Duration(seconds: 5), () => Navigator.pushNamed(context, '/'));
            }
          },
        ),
        const QrIcon(),
      ],
    );
  }
}
