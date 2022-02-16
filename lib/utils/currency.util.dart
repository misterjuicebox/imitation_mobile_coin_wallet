import '../constants.dart';
import '../models/transaction_log.model.dart';

double convert(String mob) {
  double mobAmount = double.parse(mob) / 1000000000000;
  mobAmount = double.parse(mobAmount.toStringAsFixed(4));
  return mobAmount;
}

// maybe rename this? i use it in balanceStatus set and in widget display
String setMob(String? pmob) {
  double mobAmount = double.parse(pmob!) / 1000000000000;
  return mobAmount.toStringAsFixed(4);
}

String addFee(String pmob) {
  double total = double.parse(pmob) + double.parse(feePmob);
  return total.toString();
}

String setDollars(String? pmob, double? dollarValue) {
  double dollars = (double.parse(pmob!) / 1000000000000) * dollarValue!;
  return dollars.toStringAsFixed(2);
}

double total(double value, double fee) {
  return value + fee;
}

String convertAndTotalMob(Transaction transactionLog) {
  double mobAmount = double.parse(transactionLog.valuePmob) / 1000000000000;
  double feeAmount = transactionLog.feePmob != null ? double.parse(transactionLog.feePmob!) / 1000000000000 : 0.0;
  double total = mobAmount + feeAmount;
  String direction = transactionLog.direction == "tx_direction_received" ? "+ " : "- ";
  return direction + total.toStringAsFixed(4);
}
