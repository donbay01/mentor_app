class InterestModel {
  final String name;

  InterestModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'];

  InterestModel.fromString(String docId, String text) : name = text;

  InterestModel({
    required this.name,
  });
}
