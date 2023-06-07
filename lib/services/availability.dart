import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'auth.dart';

class AvailabilityService {
  static var db = FirebaseFirestore.instance;
  static var functions = FirebaseFunctions.instance;
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
        .where('isAccepted', isEqualTo: true)
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
    var date = DateTime.now();
    var today = DateTime(
      date.year,
      date.month,
      date.day,
      date.hour,
    );
    return db
        .collection('users')
        .doc(uid)
        .collection('availables')
        .orderBy('startTimestamp')
        .where('startTimestamp',
            isGreaterThanOrEqualTo: Timestamp.fromDate(today))
        // .where('isAvailable', isEqualTo: true)
        .limit(20)
        .snapshots();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserAvailableDatesFut(
    String uid,
  ) {
    var date = DateTime.now();
    var today = DateTime(date.year, date.month, date.day);
    return db
        .collection('users')
        .doc(uid)
        .collection('availables')
        .orderBy('timestamp')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(today))
        .where('isAvailable', isEqualTo: true)
        .limit(25)
        .get();
  }

  Future<DocumentReference<Map<String, dynamic>>> addDate(
    DateTime time,
    String start,
    String end,
  ) async {
    var week = const Duration(days: 7);

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
      isAvailable: true,
    );

    var nextWeek = Shift(
      timestamp: Timestamp.fromDate(mod.add(week)),
      start: start,
      end: end,
      shiftId: '',
      startTimestamp: Timestamp.fromDate(startTime.add(week)),
      endTimestamp: Timestamp.fromDate(endTime.add(week)),
      isAvailable: true,
    );

    var a = await db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .add(data.toJson());

    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .add(nextWeek.toJson());

    // HttpsCallable callable = functions.httpsCallable('createSchedule');
    // final resp = await callable.call({
    //   'scheduleId': a.id,
    // });

    // return resp.data;
  }
}
