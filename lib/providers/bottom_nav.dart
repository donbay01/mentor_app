import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  bool _isShowCase = true;
  bool _isSeeAll = false;

  String _tab = 'jobs';
  String get tab => _tab;

  bool get isShowcase => _isShowCase;
  bool get isSeeAll => _isSeeAll;

  setIndex(int page) {
    _index = page;
    _isSeeAll = true;
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

  close() {
    _isSeeAll = false;
    // notifyListeners();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }
}
