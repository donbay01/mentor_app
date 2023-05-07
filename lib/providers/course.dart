import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CourseProvider with ChangeNotifier {
  UploadTask? _task;
  UploadTask? get task => _task;

  List<LessonModel> _lessons = [];
  List<LessonModel> get lessons => _lessons;

  List<CourseModel> _myCourses = [];
  List<CourseModel> get myCourses => _myCourses;

  var service = CourseService();

  getMyCourses() {
    service.getMyCourses().snapshots().listen((event) {
      _myCourses = event.docs
          .map(
            (e) => CourseModel.fromJson(e.id, e.data() as dynamic),
          )
          .toList();
      notifyListeners();
    });
  }

  setTask(UploadTask t) {
    _task = t;
    notifyListeners();
  }

  addLesson(LessonModel lesson) {
    _lessons.add(lesson);
    notifyListeners();
  }

  clear() {
    _task = null;
    _lessons = [];
    notifyListeners();
  }
}
