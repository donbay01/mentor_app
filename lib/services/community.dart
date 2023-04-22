import 'package:career_paddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CommunityService {
  static final db = FirebaseFirestore.instance;
  static final functions = FirebaseFunctions.instance;

  static getJobs() => db
      .collection('jobs')
      .where('type', isEqualTo: 'jobs')
      .orderBy('date', descending: true);

  static getPosts() => db
      .collection('jobs')
      .where('type', isEqualTo: 'posts')
      .orderBy('date', descending: true);

  static getComments(String jobId) => db
      .collection('jobs')
      .doc(jobId)
      .collection('comments')
      .orderBy('timestamp', descending: true);

  static Future view(String jobId) async {
    HttpsCallable callable = functions.httpsCallable('addViews');
    final resp = await callable.call(<String, dynamic>{
      'jobId': jobId,
    });

    return resp.data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> search(String query) {
    return db
        .collection('jobs')
        .where('index.${query.toLowerCase()}', isEqualTo: true)
        .limit(25)
        .get();
  }

  Future<DocumentReference<Map<String, dynamic>>> saveComment(
    String jobId,
    String comment,
    UserModel user,
  ) {
    var data = {
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
      'commenter': user.first_name + ' ' + user.last_name,
      'commenterUid': user.uid,
      'commenterImage': user.photoURL,
    };
    return db.collection('jobs').doc(jobId).collection('comments').add(data);
  }

  Future delete(String jobId, String commentId) => db
      .collection('jobs')
      .doc(jobId)
      .collection('comments')
      .doc(commentId)
      .delete();
}
