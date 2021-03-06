import 'package:flutter/cupertino.dart';
import 'package:imitation_mob_wallet/view_models/balance_status.view_model.dart';

import '../models/contact.model.dart';

class SendTransaction with ChangeNotifier {
  Contact? _contact;
  BalanceStatus? _balanceStatus;

  Contact get contact => _contact!;

  setContact(Contact contact) {
    _contact = contact;
    notifyListeners();
  }

  BalanceStatus get balanceStatus => _balanceStatus!;

  setBalanceStatus(BalanceStatus balanceStatus) {
    _balanceStatus = balanceStatus;
    notifyListeners();
  }
}
