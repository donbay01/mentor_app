class InterestModel {
  final String name;
  final bool isIndustry;

  InterestModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'],
        isIndustry = json['isIndustry'];

  InterestModel.fromString(String docId, String text)
      : name = text,
        isIndustry = false;

  InterestModel({
    required this.name,
    required this.isIndustry,
  });
}
