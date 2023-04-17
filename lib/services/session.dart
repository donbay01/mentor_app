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

  static Future<DocumentReference<Map<String, dynamic>>> bookSession(
    UserModel mentor,
    UserModel mentee,
    Shift shift,
    String meetingType,
  ) {
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
    });
  }

  static getMenteeSessions(String uid) => db
      .collection('sessions')
      .where('menteeUid', isEqualTo: uid)
      .orderBy('requestedAt')
      .limitToLast(5);

  static getMentorSessions(String uid) => db
      .collection('sessions')
      .where('mentorUid', isEqualTo: uid)
      .orderBy('requestedAt')
      .limitToLast(5);
}
