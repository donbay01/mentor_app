import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(
      Duration(days: dateTime.weekday - 1),
    );
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

  static String formatRelative(DateTime date) {
    DateTime today = DateTime.now();
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Today';
    } else if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day + 1) {
      return 'Tomorrow';
    }

    return formatMedium(date);
  }

  static TimeOfDay _getTimeOfDay(String timeString) {
    DateFormat format = DateFormat('h:mm a');
    DateTime time = format.parse(timeString);
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  static bool _isBetweenDates(DateTime startDate, DateTime endDate) {
    DateTime now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  static bool isLive(DateTime date, String start, String end) {
    var _start = _getTimeOfDay(start);
    var _end = _getTimeOfDay(end);

    var sd = DateTime(
      date.year,
      date.month,
      date.day,
      _start.hour,
      _start.minute,
    );

    var ed = DateTime(
      date.year,
      date.month,
      date.day,
      _end.hour,
      _end.minute,
    );

    return _isBetweenDates(sd, ed);
  }

  static String getMonthString(DateTime date) {
    DateFormat format = DateFormat('MMMM');
    return format.format(date);
  }

  static String formatShort(DateTime date) {
    DateFormat format = DateFormat('hh:mm a');
    return format.format(date);
  }

  static String formatMedium(DateTime date) {
    DateFormat format = DateFormat('E, dd MMMM');
    return format.format(date);
  }

  static DateTime generateEndDate(DateTime date, String end) {
    var time = _getTimeOfDay(end);
    var mod = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return mod;
  }

  static String timeAgo(DateTime date) {
    return timeago.format(date);
  }
}
