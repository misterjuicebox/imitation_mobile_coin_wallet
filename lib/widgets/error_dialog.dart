import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/line.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorDialog({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
        child: Container(
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).copyWith().size.height * 0.25,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, decoration: TextDecoration.none, fontSize: 14, fontWeight: FontWeight.w700)),
            ),
            Line(color: Colors.white10),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                child: Text('Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                onTap: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
