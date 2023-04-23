import 'package:career_paddy/models/plan_model.dart';
import 'package:flutter/material.dart';

class PlansProvider with ChangeNotifier {
  String _name = "free";
  String get name => _name;

  PlanModel? _plan;
  PlanModel? get plan => _plan;

  changeName(String name) {
    _name = name;
    notifyListeners();
  }

  setPlan(PlanModel plan) {
    _plan = plan;
    notifyListeners();
  }
}
