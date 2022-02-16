import 'dart:math';

class TransactionUtil {
  static String getRandomPmob() {
    String rand = getRandomAmount(1);
    String amount = "";
    if (double.parse(rand) > 6) {
      amount = getRandomAmount(11);
    } else {
      amount = getRandomAmount(10);
    }
    // compare amount to balance, if > repeat steps above, or auto pick smaller amount, or throw warning
    return amount;
  }

  static String getRandomAmount(int length) {
    final _chars = '1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String getReceiveAmount() {
    return '10000000000';
  }
}
