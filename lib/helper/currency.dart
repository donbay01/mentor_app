import 'package:intl/intl.dart';

class CurrencyHelper {
  static String format(double amount) {
    var formatter = NumberFormat("#,##0.00", "en_US");
    String formatted = formatter.format(amount);

    return formatted;
  }
}
