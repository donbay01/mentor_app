import 'package:career_paddy/models/lesson_model.dart';

class CourseModel {
  final String name;
  final String author;
  final String authorUid;
  final String image;
  final String about;
  final List<String> skills;
  final List<LessonModel> outlines;
  final String courseId;

  CourseModel({
    required this.name,
    required this.author,
    required this.authorUid,
    required this.image,
    required this.about,
    required this.skills,
    required this.outlines,
    required this.courseId,
  });
}
