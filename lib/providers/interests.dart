import 'dart:async';
import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';

class InterestProvider with ChangeNotifier {
  List<InterestModel>? interests;
  List<InterestModel>? get getInterests => interests;

  var service = AuthService();
  StreamSubscription? subscription;

  load() {
    subscription = service.getInterests().listen((event) {
      interests = event.docs
          .map((e) => InterestModel.fromJson(e.id, e.data()))
          .toList();
      notifyListeners();
    });
  }

  cancel() {
    subscription?.cancel();
    interests = null;
    notifyListeners();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}
