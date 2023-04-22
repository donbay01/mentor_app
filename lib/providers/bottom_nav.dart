import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  String _tab = 'jobs';
  String get tab => _tab;

  setIndex(int page) {
    _index = page;
    notifyListeners();
  }

  setTab(String tab) {
    _tab = tab;
    notifyListeners();
  }
}
