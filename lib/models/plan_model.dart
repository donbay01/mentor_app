class PlanModel {
  final String planId;
  final String name;
  final bool isLearning;
  final int sessions;
  final int interviews;
  final int amount;

  PlanModel.fromJson(String docId, Map<String, dynamic> json)
      : name = json['name'],
        isLearning = json['isLearning'],
        sessions = json['sessions'],
        interviews = json['interviews'],
        amount = json['amount'],
        planId = docId;

  PlanModel({
    required this.planId,
    required this.name,
    required this.isLearning,
    required this.sessions,
    required this.interviews,
    required this.amount,
  });
}
