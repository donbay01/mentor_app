import 'package:cloud_firestore/cloud_firestore.dart';

class UserExperience {
  final String jobRole;
  final String company;
  final Timestamp start, end;

  Map<String, dynamic> toJson() => {
        'jobRole': jobRole,
        'start': start,
        'end': end,
        'company': company,
      };

  UserExperience.fromJson(Map<String, dynamic> json)
      : jobRole = json['jobRole'],
        start = json['start'],
        end = json['end'],
        company = json['company'];

  UserExperience({
    required this.jobRole,
    required this.company,
    required this.start,
    required this.end,
  });
}
