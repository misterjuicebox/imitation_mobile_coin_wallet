import 'package:flutter/material.dart';

import '../models/contact.model.dart';
import '../widgets/contact_icon.dart';

class ContactRowItem extends StatelessWidget {
  final Contact contact;
  const ContactRowItem({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
        child: Row(
          children: [
            ContactIcon(contact: contact),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(contact.firstName + " " + contact.lastName,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            )
          ],
        ));
  }
}
