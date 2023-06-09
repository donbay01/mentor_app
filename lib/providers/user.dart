import 'dart:async';
import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/models/user_experience.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/shift.dart';

class UserProvider with ChangeNotifier {
  UserModel? user;
  bool hasLoaded = false;

  InterestModel? _interest, _job;
  InterestModel? get interest => _interest;
  InterestModel? get job => _job;

  UserModel get getUser => user!;
  bool get getHasLoaded => hasLoaded;

  StreamSubscription? subscription;

  var service = AuthService();

  List<InterestModel>? _interests;
  List<UserExperience> _experiences = [];

  String? _gender, _field, _company, _employment, _resume, _linkedin, _bio, _qg;
  bool? _isCareerMentor, _isMockInterviewer;

  String? get getGender => _gender;
  String? get gq => _qg;
  String? get getField => _field;
  String? get getCompany => _company;
  String? get getEmployment => _employment;
  String? get getResume => _resume;
  String? get getLinkedin => _linkedin;
  String? get bio => _bio;

  String? _jobRole, _note;
  String? get jobRole => _jobRole;
  String? get note => _note;

  List<InterestModel>? get getInterests => _interests;
  List<UserExperience> get experiences => _experiences;

  Shift? _shift;
  Shift? get shift => _shift;

  bool? get isCareerMentor => _isCareerMentor;

  bool? get isMockInterviewer => _isMockInterviewer;

  Query<Map<String, dynamic>>? _query;
  Query<Map<String, dynamic>>? get query => _query;

  setInterest(InterestModel i) {
    _interest = i;
    notifyListeners();
  }

  holdJob(InterestModel i) {
    _job = i;
    notifyListeners();
  }

  setQuery(Query<Map<String, dynamic>>? query) {
    _query = query;
    notifyListeners();
  }

  setRole(String r) {
    _jobRole = r;
    notifyListeners();
  }

  setNote(String n) {
    _note = n;
    notifyListeners();
  }

  clearMentorNote() {
    _jobRole = null;
    _note = null;

    notifyListeners();
  }

  clearQuery({bool isMounted = true}) {
    _query = null;
    _interest = null;
    _job = null;
    _qg = null;

    if (isMounted) {
      notifyListeners();
    }
  }

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
    user = null;
    subscription?.cancel();
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

  holdqg(String value) {
    _qg = value;
    notifyListeners();
  }

  holdGender(String value) {
    _gender = value;
    notifyListeners();
  }

  holdField(String value) {
    _field = value;
    notifyListeners();
  }

  holdCompany(String value) {
    _company = value;
    notifyListeners();
  }

  holdEmployment(String value) {
    _employment = value;
    notifyListeners();
  }

  holdResume(String value) {
    _resume = value;
    notifyListeners();
  }

  holdLinkedin(String value) {
    _linkedin = value;
    notifyListeners();
  }

  holdInterests(List<InterestModel> value) {
    _interests = value;
    notifyListeners();
  }

  holdBio(String value) {
    _bio = value;
    notifyListeners();
  }

  holdMockInterview(bool val) => _isMockInterviewer = val;

  holdCareerMentor(bool val) => _isCareerMentor = val;

  addExperience(UserExperience experience) {
    _experiences.add(experience);
    notifyListeners();
  }
}
