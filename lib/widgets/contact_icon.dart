import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import '../models/contact.model.dart';

class ContactIcon extends StatelessWidget {
  final Contact contact;
  const ContactIcon({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineGradientButton(
            // todo improve this so that the gradient box stays the same size when any two characters fill the box
            // a container with a fixed size and boxdecoration gradient border should do the trick
            padding: EdgeInsets.fromLTRB(5.5, 8.8, 5.5, 8.8),
            child: Text(
              '${contact.firstName[0]} ${contact.lastName[0]}', // todo this blows up if no lastname is set
              style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: .6),
            ),
            gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.yellow]),
            strokeWidth: 2.2,
            radius: Radius.circular(4),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
