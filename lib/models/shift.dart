import 'package:cloud_firestore/cloud_firestore.dart';

class Shift {
  final Timestamp timestamp;
  final String start, end;
  final String shiftId;

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'start': start,
        'end': end,
      };

  Shift.fromJson(String docId, Map<String, dynamic> json)
      : timestamp = json['timestamp'],
        start = json['start'],
        end = json['end'],
        shiftId = docId;

  Shift({
    required this.timestamp,
    required this.start,
    required this.end,
    required this.shiftId,
  });
}
