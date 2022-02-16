import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: Text(errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, decoration: TextDecoration.none, fontSize: 14, fontWeight: FontWeight.w300)),
    ));
  }
}
