import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  final Function add;
  final Function remove;
  final double? mobPrice; // would prefer not to pass mobPrice into this widget and have conditionals based off it

  const KeyPad({required this.add, required this.remove, this.mobPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
                child: Text('1', style: TextStyle(fontSize: 35)),
                onTap: () {
                  return mobPrice != null ? add('1', mobPrice) : add('1', context);
                }),
            GestureDetector(
                child: Text('2', style: TextStyle(fontSize: 35)),
                onTap: () => mobPrice != null ? add('2', mobPrice) : add('2', context)),
            GestureDetector(
                child: Text('3', style: TextStyle(fontSize: 35)),
                onTap: () => mobPrice != null ? add('3', mobPrice) : add('3', context)),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  child: Text('4', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('4', mobPrice) : add('4', context)),
              GestureDetector(
                  child: Text('5', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('5', mobPrice) : add('5', context)),
              GestureDetector(
                  child: Text('6', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('6', mobPrice) : add('6', context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  child: Text('7', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('7', mobPrice) : add('7', context)),
              GestureDetector(
                  child: Text('8', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('8', mobPrice) : add('8', context)),
              GestureDetector(
                  child: Text('9', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('9', mobPrice) : add('9', context)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  child: Text(mobPrice != null ? '.' : ' ', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('.', mobPrice) : null),
              GestureDetector(
                  child: Text('0', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? add('0', mobPrice) : add('0', context)),
              GestureDetector(
                  child: Text('x', style: TextStyle(fontSize: 35)),
                  onTap: () => mobPrice != null ? remove(mobPrice) : remove()),
            ],
          )
        ]),
        height: 350,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.5), borderRadius: BorderRadius.circular(10)));
  }
}
