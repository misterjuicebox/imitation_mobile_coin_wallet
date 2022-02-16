import 'package:intl/intl.dart';

class DateUtil {
  static String cleanAndConvert(String date) {
    date = date.replaceAll(' UTC', '');
    return new DateFormat("MMM d, yyyy").format(DateTime.parse(date));
  }
}
