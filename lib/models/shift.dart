import 'package:cloud_firestore/cloud_firestore.dart';

class Shift {
  final Timestamp timestamp, startTimestamp, endTimestamp;
  final String start, end;
  final String shiftId;
  final bool isAvailable;

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'start': start,
        'end': end,
        'isAvailable': true,
        'startTimestamp': startTimestamp,
        'endTimestamp': endTimestamp,
      };

  Shift.fromJson(String docId, Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        start = json['start'],
        end = json['end'],
        shiftId = docId,
        startTimestamp = json['startTimestamp'],
        endTimestamp = json['endTimestamp'],
        isAvailable = json['isAvailable'];

  Shift({
    required this.timestamp,
    required this.start,
    required this.end,
    required this.shiftId,
    required this.startTimestamp,
    required this.endTimestamp,
    required this.isAvailable,
  });
}
