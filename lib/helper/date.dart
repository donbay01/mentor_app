import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateHelper {
  static String formatDate(DateTime date) {
    String res = DateFormat('EEEE, d\'${_getOrdinalSuffix(date.day)}\' MMMM y')
        .format(date);
    return res;
  }

  static String getAM(DateTime time) {
    return DateFormat('h a').format(time);
  }

  static String formatShift(DateTime date) {
    var res = DateFormat('E, d\'${_getOrdinalSuffix(date.day)}\'').format(date);
    return res;
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = new DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  static String getTimeOfDayString(String time) {
    TimeOfDay parsedTime = TimeOfDay(
      hour: int.parse(time.split(':')[0]),
      minute: int.parse(time.split(':')[1]),
    );

    DateTime dateTime = DateTime(0, 0, 0, parsedTime.hour, parsedTime.minute);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime;
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

  static TimeOfDay getTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].replaceAll(RegExp(r'[^0-9]'), ''));

    if (timeString.contains('PM') && hour != 12) {
      hour += 12;
    } else if (timeString.contains('AM') && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  static bool _isBetweenDates(DateTime startDate, DateTime endDate) {
    DateTime now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  static bool isLive(DateTime date, String start, String end) {
    var _start = getTimeOfDay(start);
    var _end = getTimeOfDay(end);

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
    var time = getTimeOfDay(end);
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

  static String addMinute(TimeOfDay time, int minutes) {
    var now = DateTime.now();
    var date = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    var newDate = date.add(Duration(minutes: minutes));

    return getAM(newDate);
  }
}
