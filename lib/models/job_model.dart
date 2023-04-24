import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String role;
  final String? image;
  final Timestamp date;
  final String intro;
  final int minPay;
  final int maxPay;
  final String experience;
  final List<String> descriptions;
  final List<String> qualifications;
  final String? jobId;
  final String? company;

  Map<String, dynamic> toJson() => {
        'role': role,
        'image': image,
        'date': date,
        'intro': intro,
        'minPay': minPay,
        'maxPay': maxPay,
        'experience': experience,
        'descriptions': descriptions,
        'qualifications': qualifications,
        'indexed': false,
        'type': 'jobs',
        'company': company,
      };

  JobModel.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        image = json['image'],
        date = json['date'],
        intro = json['intro'],
        minPay = json['minPay'],
        maxPay = json['maxPay'],
        experience = json['experience'],
        descriptions = json['descriptions'].cast<String>(),
        qualifications = json['qualifications'].cast<String>(),
        company = json['company'],
        jobId = json['jobId'];

  JobModel({
    required this.role,
    this.image,
    required this.date,
    required this.intro,
    required this.minPay,
    required this.maxPay,
    required this.experience,
    required this.descriptions,
    required this.qualifications,
    this.jobId,
    this.company,
  });
}
