import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  const InfoBox();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 340,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white38, width: 1.4), borderRadius: BorderRadius.circular(5.5)),
      child: Row(
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 5, 0),
              child: Container(
                width: 210,
                height: 70,
                child: Text(
                  'Click here to buy MOB. Currently available to non-US users. We are launching a US on-ramp soon!',
                  style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: .4, height: 1.4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Container(
                width: 210,
                height: 20,
                child: Text(
                  'LEARN MORE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1, height: 1.4),
                ),
              ),
            ),
          ]),
          Column(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 7, 80, 0)),
            Container(
                height: 95,
                width: 95,
                child: Image.asset(
                  'assets/learn_more.png',
                  fit: BoxFit.fill,
                ))
          ]),
        ],
      ),
    );
  }
}
