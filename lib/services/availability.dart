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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserAvailableDates(
    String uid,
  ) {
    return db
        .collection('users')
        .doc(uid)
        .collection('availables')
        .orderBy('timestamp')
        .limit(25)
        .snapshots();
  }

  Future<DocumentReference<Map<String, dynamic>>> addDate(
    DateTime time,
    String start,
    String end,
  ) {
    var data = Shift(
      timestamp: Timestamp.fromDate(time),
      start: start,
      end: end,
    );

    return db
        .collection('users')
        .doc(user.uid)
        .collection('availables')
        .add(data.toJson());
  }
}
