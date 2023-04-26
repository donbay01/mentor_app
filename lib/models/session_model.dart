import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final Timestamp timestamp, requestedAt, endTimestamp, startTimestamp;
  final String start, end, note;
  final String mentorUid, menteeUid, mentorEmail, menteeEmail, mentee, mentor;
  final String sessionId, meetingType;
  final String? menteeImage, menteePhone, mentorImage, mentorPhone;

  SessionModel.fromJson(String docId, Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        requestedAt = json['requestedAt'],
        start = json['start'],
        end = json['end'],
        sessionId = docId,
        mentorUid = json['mentorUid'],
        menteeUid = json['menteeUid'],
        mentorEmail = json['mentorEmail'],
        menteeEmail = json['menteeEmail'],
        mentee = json['mentee'],
        mentor = json['mentor'],
        menteeImage = json['menteeImage'],
        menteePhone = json['menteePhone'],
        mentorImage = json['mentorImage'],
        mentorPhone = json['mentorPhone'],
        meetingType = json['meetingType'],
        startTimestamp = json['startTimestamp'],
        endTimestamp = json['endTimestamp'],
        note = json['note'];

  SessionModel({
    required this.sessionId,
    required this.timestamp,
    required this.requestedAt,
    required this.start,
    required this.end,
    required this.mentorUid,
    required this.menteeUid,
    required this.mentorEmail,
    required this.menteeEmail,
    required this.mentee,
    required this.mentor,
    this.menteeImage,
    this.menteePhone,
    this.mentorImage,
    this.mentorPhone,
    required this.meetingType,
    required this.endTimestamp,
    required this.startTimestamp,
    required this.note,
  });
}
