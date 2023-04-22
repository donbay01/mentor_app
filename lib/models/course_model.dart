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
  final int enrolled;
  final double rating;

  Map<String, dynamic> toJson() => {
        'name': name,
        'author': author,
        'authorUid': authorUid,
        'image': image,
        'about': about,
        'skills': skills,
        'outlines': outlines,
        'courseId': courseId,
        'enrolled': 0,
        'rating': 0.0,
      };

  CourseModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'],
        author = json['author'],
        authorUid = json['authorUid'],
        image = json['image'],
        about = json['about'],
        skills = json['skills'].cast<String>(),
        outlines = json['outlines']
            .map((e) => LessonModel.fromJson(e))
            .toList()
            .cast<LessonModel>(),
        enrolled = json['enrolled'],
        rating = json['rating'].toDouble(),
        courseId = docId;

  CourseModel({
    required this.name,
    required this.author,
    required this.authorUid,
    required this.image,
    required this.about,
    required this.skills,
    required this.outlines,
    required this.courseId,
    this.enrolled = 0,
    this.rating = 0.0,
  });
}
