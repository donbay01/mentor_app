import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime _today = DateTime.now();
  DateTime _selected = DateTime.now();
  bool _enabled = false;

  DateTime get today => _today;
  DateTime get selected => _selected;
  bool get enabled => _enabled;

  setDate(DateTime dateTime) {
    _selected = dateTime;
    notifyListeners();
  }

  setEnabled(bool val) {
    _enabled = val;
    notifyListeners();
  }
}
