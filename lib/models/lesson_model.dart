class LessonModel {
  final String name;
  final String image;
  final String lessonId;

  LessonModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'],
        lessonId = json['lessonId'];

  LessonModel({
    required this.name,
    required this.image,
    required this.lessonId,
  });
}
