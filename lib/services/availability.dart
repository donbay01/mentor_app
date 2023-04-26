import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class AvailabilityService {
  static var db = FirebaseFirestore.instance;
  static var auth = AuthService();

  static var user = auth.getFirebaseUser()!;

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAvailableDates(
    DateTime date,
  ) {
    var mod = DateTime(date.year, date.month, date.day, 0);
    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .orderBy('start')
        .where(
          'timestamp',
          isEqualTo: Timestamp.fromDate(mod),
        )
        .limit(25)
        .snapshots();
  }

  static delete(String id) {
    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .doc(id)
        .delete();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAvailableDatesFuture(
    DateTime date,
  ) {
    var mod = DateTime(date.year, date.month, date.day, 0);
    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .orderBy('start')
        .where(
          'timestamp',
          isEqualTo: Timestamp.fromDate(mod),
        )
        .limit(25)
        .get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getSessions(
    DateTime date,
  ) {
    var mod = DateTime(date.year, date.month, date.day, 0);

    return db
        .collection('sessions')
        .where('mentorUid', isEqualTo: user.uid)
        .where(
          'timestamp',
          isEqualTo: Timestamp.fromDate(mod),
        )
        .limit(25)
        .get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserAvailableDates(
    String uid,
  ) {
    var today = Timestamp.now();
    return db
        .collection('users')
        .doc(uid)
        .collection('availables')
        .orderBy('timestamp')
        .where('timestamp', isGreaterThanOrEqualTo: today)
        .where('isAvailable', isEqualTo: true)
        .limit(25)
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addDate(
    DateTime time,
    String start,
    String end,
  ) {
    var startTime = DateHelper.generateEndDate(time, start);
    var endTime = DateHelper.generateEndDate(time, end);
    var mod = DateTime(time.year, time.month, time.day, 0);

    var data = Shift(
      timestamp: Timestamp.fromDate(mod),
      start: start,
      end: end,
      shiftId: '',
      startTimestamp: Timestamp.fromDate(startTime),
      endTimestamp: Timestamp.fromDate(endTime),
    );

    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .add(data.toJson());
  }
}
