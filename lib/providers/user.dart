import 'dart:async';

import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/models/user_experience.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';

import '../models/shift.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;
  bool hasLoaded = false;

  UserModel get getUser => user!;
  bool get getHasLoaded => hasLoaded;

  StreamSubscription? subscription;

  var service = AuthService();

  List<InterestModel>? _interests;
  List<UserExperience> _experiences = [];

  String? _gender, _field, _company, _employment, _resume, _linkedin, _bio;
  bool? _isCareerMentor, _isMockInterviewer;

  String? get getGender => _gender;
  String? get getField => _field;
  String? get getCompany => _company;
  String? get getEmployment => _employment;
  String? get getResume => _resume;
  String? get getLinkedin => _linkedin;
  String? get bio => _bio;

  List<InterestModel>? get getInterests => _interests;
  List<UserExperience> get experiences => _experiences;

  Shift? _shift;
  Shift? get shift => _shift;

  bool? get isCareerMentor => _isCareerMentor;

  bool? get isMockInterviewer => _isMockInterviewer;

  listenToUser() {
    service.listenToAuth().listen((u) {
      if (u != null) {
        subscription = service.listen(u.uid).listen((event) {
          var model = UserModel.fromJson(
            event.id,
            event.data() as dynamic,
          );
          user = model;
          hasLoaded = true;

          _gender = user?.gender;
          _company = user?.company;
          _field = user?.field;
          _employment = user?.employment;
          _resume = user?.resume;
          _linkedin = user?.linkedin;
          _interests = user?.interests;
          _bio = user?.bio;
          _experiences = user?.experiences ?? [];

          notifyListeners();
        });
      } else {
        cancel();
      }
    });
  }

  cancel() {
    subscription?.cancel();
    user = null;
    notifyListeners();
  }

  cancelShift() {
    _shift = null;
    notifyListeners();
  }

  setShift(Shift s) {
    _shift = s;
    notifyListeners();
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  holdGender(String value) => _gender = value;
  holdField(String value) => _field = value;
  holdCompany(String value) => _company = value;
  holdEmployment(String value) => _employment = value;
  holdResume(String value) => _resume = value;
  holdLinkedin(String value) => _linkedin = value;
  holdInterests(List<InterestModel> value) => _interests = value;
  holdBio(String value) => _bio = value;

  holdMockInterview(bool val) => _isMockInterviewer = val;

  holdCareerMentor(bool val) => _isCareerMentor = val;

  addExperience(UserExperience experience) {
    _experiences.add(experience);
    notifyListeners();
  }
}
