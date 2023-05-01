import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  bool _isShowCase = true;

  String _tab = 'jobs';
  String get tab => _tab;

  bool get isShowcase => _isShowCase;

  setIndex(int page) {
    _index = page;
    notifyListeners();
  }

  setTab(String tab) {
    _tab = tab;
    notifyListeners();
  }

  setVisibility(bool val) {
    _isShowCase = val;
    notifyListeners();
  }
}
