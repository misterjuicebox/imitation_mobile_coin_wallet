import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .65,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.exclamationmark_triangle,
                color: Colors.deepPurpleAccent,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  'Something went wrong loading your account activity',
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width * .8,
                child: Text(
                  'Did you fill out the account_constants.dart file? Are two instances of Full Service running? Follow the README.md?',
                  textAlign: TextAlign.center,
                )),
            Container(
              padding: EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * .7,
              child: Text(
                'Feedback & Support bootstrapjuicebox@gmail.com',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
