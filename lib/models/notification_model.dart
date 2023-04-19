import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final Timestamp timestamp;
  final String image;
  final String notificationId;

  NotificationModel.fromJson(String docId, Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        title = json['title'],
        body = json['body'],
        image = json['image'],
        notificationId = docId;

  NotificationModel({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.image,
    required this.notificationId,
  });
}
