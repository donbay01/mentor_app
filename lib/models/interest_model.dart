class InterestModel {
  final String name;

  InterestModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'];

  InterestModel({
    required this.name,
  });
}
