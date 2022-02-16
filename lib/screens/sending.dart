import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Sending extends StatelessWidget {
  const Sending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GFLoader(
          androidLoaderColor: AlwaysStoppedAnimation<Color>(Colors.white),
          loaderColorOne: Colors.white,
          loaderstrokeWidth: 2.5,
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0), child: Text('Sending...', style: TextStyle(fontSize: 11)))
      ],
    )));
  }
}
