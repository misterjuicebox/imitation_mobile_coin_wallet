import 'package:flutter/cupertino.dart';

import './contact.model.dart';

class VerifyingTransaction with ChangeNotifier {
  final Contact contact;
  final String pmob;
  final String sentTime;
  final String submittedBlockIndex;

  VerifyingTransaction(
      {required this.contact, required this.pmob, required this.sentTime, required this.submittedBlockIndex});
}
