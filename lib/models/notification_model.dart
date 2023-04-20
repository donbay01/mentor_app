import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final Timestamp timestamp, shift_date;
  final String? image, other_image, sessionId;
  final String notificationId, start, end, meetingType, mentor, mentee;

  NotificationModel.fromJson(String docId, Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        title = json['title'],
        body = json['body'],
        image = json['image'],
        other_image = json['other_image'],
        shift_date = json['shift_date'],
        start = json['start'],
        end = json['end'],
        notificationId = docId,
        meetingType = json['meetingType'],
        mentee = json['mentee'],
        mentor = json['mentor'],
        sessionId = json['sessionId'];

  NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
    this.image,
    this.other_image,
    required this.notificationId,
    required this.shift_date,
    required this.start,
    required this.end,
    required this.meetingType,
    required this.mentee,
    required this.mentor,
    this.sessionId,
  });
}
