import 'package:imitation_mob_wallet/models/get_all_transaction_logs_for_account_response.dart';

import './contact.model.dart';
import '../account_constants.dart' as Constants;

class Transaction {
  final String id;
  final String direction;
  final String sentTime;
  final String valuePmob;
  final String? feePmob;
  final Contact? contact;
  final String finalizedBlockIndex;
  final String? assignedAddressId;
  bool confirm;

  Transaction(
      {required this.id,
      required this.direction,
      required this.sentTime,
      required this.valuePmob,
      this.feePmob,
      required this.finalizedBlockIndex,
      this.assignedAddressId,
      this.contact,
      this.confirm = false});

  Map toJson() => {
        'id': id,
        'direction': direction,
        'sentTime': sentTime,
        'valuePmob': valuePmob,
        'feePmob': feePmob,
        'contact': contact,
        'finalizedBlockIndex': finalizedBlockIndex,
        'assignedAddressId': assignedAddressId,
      };

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        direction = json['direction'],
        sentTime = json['sentTime'],
        valuePmob = json['valuePmob'],
        feePmob = json['feePmob'],
        contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null,
        finalizedBlockIndex = json['finalizedBlockIndex'],
        assignedAddressId = json['assignedAddressId'],
        confirm = json['confirm'];

  static verify(TransactionLogMap transactionLog) {
    // this is to filter out received transactions that are actually part of sent transactions
    // likely not best way to do this, but best I could figure out via full sevice api
    if (transactionLog.direction == "tx_direction_received" &&
        transactionLog.assignedAddressId != Constants.PrimaryAccount.mainAddress) {
      return false;
    }
    if (transactionLog.valuePmob == null) {
      return false;
    } else if (transactionLog.finalizedBlockIndex == null) {
      return false;
    } else {
      return true;
    }
  }
}
