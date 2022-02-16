import 'package:flutter/material.dart';

class TransactionIdIcon extends StatelessWidget {
  final String transactionId;
  const TransactionIdIcon({required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white30, width: 2.2), borderRadius: BorderRadius.circular(5.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transactionId[0], style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500)),
              Text(transactionId[1], style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transactionId[3], style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500)),
              Text(transactionId[4], style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
