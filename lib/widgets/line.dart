import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color;
  const Line({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white70, width: .2, style: BorderStyle.solid))),
    );
  }
}
