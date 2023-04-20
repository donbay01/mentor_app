import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SessionService {
  static var db = FirebaseFirestore.instance;
  static var functions = FirebaseFunctions.instance;

  static Future<String> getToken(int uid, String channel) async {
    var callable = functions.httpsCallable('createToken');
    final results = await callable.call(<String, dynamic>{
      'uid': uid,
      'channelName': channel,
    });
    return results.data;
  }

  static Future makeDecision(
    String action,
    String sessionId,
    String notificationId,
    String? reason,
  ) async {
    var callable = functions.httpsCallable('sessionAction');
    final results = await callable.call(<String, dynamic>{
      'action': action,
      'reason': reason,
      'sessionId': sessionId,
      'notificationId': notificationId,
    });
    return results.data;
  }

  Future<void> deleteSession(String id) {
    return db.collection('sessions').doc(id).delete();
  }

  static Future<DocumentReference<Map<String, dynamic>>> bookSession(
    UserModel mentor,
    UserModel mentee,
    Shift shift,
    String meetingType,
  ) async {
    await db
        .collection('users')
        .doc(mentor.uid)
        .collection('availables')
        .doc(shift.shiftId)
        .update({'isAvailable': false});
    return db.collection('sessions').add({
      'timestamp': shift.timestamp,
      'requestedAt': FieldValue.serverTimestamp(),
      'start': shift.start,
      'end': shift.end,
      'mentorUid': mentor.uid,
      'mentor': '${mentor.first_name} ${mentor.last_name}',
      'mentorEmail': mentor.email,
      'mentorImage': mentor.photoURL,
      'mentorPhone': mentor.phoneNumber,
      'menteeUid': mentee.uid,
      'mentee': '${mentee.first_name} ${mentee.last_name}',
      'menteeEmail': mentee.email,
      'menteeImage': mentee.photoURL,
      'menteePhone': mentee.phoneNumber,
      'isAccepted': false,
      'meetingType': meetingType,
      'shiftId': shift.shiftId,
      'endTimestamp': shift.endTimestamp,
    });
  }

  static getMenteeSessions(String uid) => db
      .collection('sessions')
      .where('menteeUid', isEqualTo: uid)
      .where('isAccepted', isEqualTo: true)
      .orderBy('requestedAt', descending: true)
      .limitToLast(5);

  static getMentorSessions(String uid) => db
      .collection('sessions')
      .where('mentorUid', isEqualTo: uid)
      .where('isAccepted', isEqualTo: true)
      .orderBy('requestedAt', descending: true)
      .limitToLast(5);
}
