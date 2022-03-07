import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/line.dart';

class ErrorDialog extends StatelessWidget {
  final bool? error;
  final String errorMessage;

  const ErrorDialog({required this.errorMessage, this.error});

  showError() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text('Error',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, decoration: TextDecoration.none, fontSize: 20, fontWeight: FontWeight.w700)),
      ),
    );
  }

  showLine() {
    return Line(color: Colors.white10);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
        child: Container(
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: error != null
          ? MediaQuery.of(context).copyWith().size.height * 0.35
          : MediaQuery.of(context).copyWith().size.height * 0.25,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null) showError(),
            if (error != null) showLine(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: error != null ? 0.0 : 30),
              child: Text(errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, decoration: TextDecoration.none, fontSize: 16, fontWeight: FontWeight.w700)),
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
                        fontSize: 16,
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
