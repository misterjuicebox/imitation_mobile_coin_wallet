import '../constants.dart';
import '../models/transaction_log.model.dart';

double convert(String mob) {
  double mobAmount = double.parse(mob) / 1000000000000;
  mobAmount = double.parse(mobAmount.toStringAsFixed(4));
  return mobAmount;
}

String convertToDisplayMob(String? pmob) {
  double displayMob = double.parse(pmob!) / 1000000000000;
  return displayMob.toStringAsFixed(4);
}

String convertToPmob(String? displayMob) {
  String pmob = displayMob ?? '';
  pmob = pmob.replaceFirst(RegExp(r'\.'), '');
  int pico = 13 - pmob.length;
  for (int i = 0; i < pico; i++) {
    pmob += "0";
  }
  return pmob;
}

String addFee(String pmob) {
  double total = double.parse(pmob) + double.parse(feePmob);
  return total.toString();
}

String setDollars(String? pmob, double? dollarValue) {
  double dollars = (double.parse(pmob!) / 1000000000000) * dollarValue!;
  return dollars.toStringAsFixed(2);
}

String convertDollarsToDisplayMob(String dollars, double mobPrice) {
  double pmob = double.parse(dollars) / mobPrice;
  return pmob.toStringAsFixed(4);
}

String convertDisplayMobToDollars(String displayMob, double mobPrice) {
  double dollars = double.parse(displayMob) * mobPrice;
  return dollars.toStringAsFixed(2);
}

String convertPmobToDollars(String pmob, double mobPrice) {
  double dollars = double.parse(pmob) * mobPrice;
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
