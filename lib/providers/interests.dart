import 'dart:async';
import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';

class InterestProvider with ChangeNotifier {
  List<InterestModel> interests = [], _industries = [];

  List<InterestModel> get getInterests => interests;
  List<InterestModel> get industries => _industries;

  var service = AuthService();
  StreamSubscription? subscription, ind;

  load() {
    subscription = service.getInterests().listen((event) {
      interests = event.docs
          .map((e) => InterestModel.fromJson(e.id, e.data()))
          .toList();
      notifyListeners();
    });

    getIndustries();
  }

  getIndustries() {
    ind = service.getIndustries().listen((event) {
      _industries = event.docs
          .map((e) => InterestModel.fromJson(e.id, e.data()))
          .toList();
      notifyListeners();
    });
  }

  cancel() {
    subscription?.cancel();
    ind?.cancel();
    interests = [];
    _industries = [];
    notifyListeners();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}
