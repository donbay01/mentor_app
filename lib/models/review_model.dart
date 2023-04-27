import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final Timestamp timestamp;
  final double stars;
  final String? review;
  final String mentee;
  final String menteeUid;
  final String menteeEmail;
  final String meetingType;
  final String? menteeImage;

  ReviewModel.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        stars = json['stars'],
        review = json['review'],
        mentee = json['mentee'],
        menteeUid = json['menteeUid'],
        menteeEmail = json['menteeEmail'],
        menteeImage = json['menteeImage'],
        meetingType = json['meetingType'];

  ReviewModel({
    required this.timestamp,
    required this.stars,
    required this.review,
    required this.mentee,
    required this.menteeUid,
    required this.menteeEmail,
    required this.meetingType,
    this.menteeImage,
  });
}
