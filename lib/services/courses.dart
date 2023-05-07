import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CourseService {
  static final db = FirebaseFirestore.instance;
  static final functions = FirebaseFunctions.instance;

  var user = AuthService().getFirebaseUser();

  static getLessons(String courseId) {
    return db
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .orderBy('timestamp');
  }

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

  static Future<void> addCourse(
    CourseModel course,
  ) async {
    var doc = await db.collection('courses').add(course.toJson());
    await doc.update({
      'courseId': doc.id,
      'timestamp': FieldValue.serverTimestamp(),
    });

    var ref = doc.collection('lessons');
    return course.outlines.forEach((element) async {
      var a = await ref.add(element.toJson());
      await a.update({
        'lessonId': a.id,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  static Future<LessonModel?> nextLesson(
    String courseId,
    String lessonId,
  ) async {
    var callable = functions.httpsCallable('nextLesson');
    final resp = await callable.call(<String, dynamic>{
      'courseId': courseId,
      'lessonId': lessonId,
    });

    if (resp.data == null) {
      return null;
    }

    return LessonModel.fromJson(null, resp.data);
  }

  Future<AggregateQuerySnapshot> getProgress(String courseId) {
    var uid = user!.uid;

    var ref = db
        .collection('users')
        .doc(uid)
        .collection('courses')
        .doc(courseId)
        .collection('logs');

    return ref.count().get();
  }

  Future<LessonModel> getStartLesson(String courseId) async {
    var next = await db
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .orderBy('timestamp')
        .limit(1)
        .get();
    var doc = next.docs.first;

    return LessonModel.fromJson(doc.id, doc.data() as dynamic);
  }

  Query<Map<String, dynamic>> getMyCourses() {
    return db
        .collection('courses')
        .where('enrolledUids', arrayContains: user!.uid)
        .limit(25);
  }
}
