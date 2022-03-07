import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinDots extends StatelessWidget {
  final String pin;

  const PinDots({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 0 ? Colors.white : Colors.white24,
          size: 12,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 1 ? Colors.white : Colors.white24,
          size: 12,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 2 ? Colors.white : Colors.white24,
          size: 12,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 3 ? Colors.white : Colors.white24,
          size: 12,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 4 ? Colors.white : Colors.white24,
          size: 12,
        ),
        Icon(
          CupertinoIcons.circle_fill,
          color: pin.length > 5 ? Colors.white : Colors.white24,
          size: 12,
        ),
      ],
    );
  }
}
