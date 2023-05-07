class LessonModel {
  final String name;
  final String image;
  final String description;
  final String? lessonId;

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'description': description,
      };

  LessonModel.fromJson(String? docId, Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'],
        description = json['description'] ?? '',
        lessonId = docId ?? json['lessonId'];

  LessonModel({
    required this.name,
    required this.image,
    this.lessonId,
    required this.description,
  });
}
