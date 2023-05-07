import 'package:career_paddy/models/lesson_model.dart';

class CourseModel {
  final String name;
  final String author;
  final String authorUid;
  final String image;
  final String about;
  final List<String> skills;
  final List<LessonModel> outlines;
  final String? courseId;
  final int enrolled;
  final double rating;
  final List<String> enrolledUids;

  Map<String, dynamic> toJson() => {
        'name': name,
        'author': author,
        'authorUid': authorUid,
        'image': image,
        'about': about,
        'skills': skills.cast<dynamic>(),
        'outlines': outlines.map((e) => e.toJson()).toList().cast<dynamic>(),
        'courseId': courseId,
        'enrolled': 0,
        'rating': 0.0,
        'enrolledUids': [],
      };

  CourseModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'],
        author = json['author'],
        authorUid = json['authorUid'],
        image = json['image'],
        about = json['about'],
        skills = json['skills'].cast<String>(),
        outlines = json['outlines']
            .map((e) => LessonModel.fromJson(e['lessonId'] ?? '', e))
            .toList()
            .cast<LessonModel>(),
        enrolled = json['enrolled'],
        rating = json['rating'].toDouble(),
        courseId = docId,
        enrolledUids = json['enrolledUids'].cast<String>();

  CourseModel({
    required this.name,
    required this.author,
    required this.authorUid,
    required this.image,
    required this.about,
    required this.skills,
    required this.outlines,
    this.courseId,
    this.enrolled = 0,
    this.rating = 0.0,
    this.enrolledUids = const [],
  });
}
