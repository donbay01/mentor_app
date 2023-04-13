import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    String res = DateFormat('EEEE, d\'${_getOrdinalSuffix(date.day)}\' MMMM y')
        .format(date);
    return res;
  }

  static String formatShift(DateTime date) {
    var res = DateFormat('E, d\'${_getOrdinalSuffix(date.day)}\'').format(date);
    return res;
  }

  static String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
