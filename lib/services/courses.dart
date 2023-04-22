import 'package:career_paddy/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService {
  static final db = FirebaseFirestore.instance;
  var user = AuthService().getFirebaseUser();

  static getCourses() =>
      db.collection('courses').orderBy('timestamp', descending: true);

  Future<void> enroll(String courseId) {
    var uid = user!.uid;

    return db
        .collection('courses')
        .doc(courseId)
        .collection('enrolled')
        .doc(uid)
        .set({
      'uid': uid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> search(String query) {
    return db
        .collection('courses')
        .where('index.${query.toLowerCase()}', isEqualTo: true)
        .limit(25)
        .get();
  }
}
