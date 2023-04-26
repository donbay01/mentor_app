import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/models/job_model.dart';
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
      .collection('posts')
      .where('type', isEqualTo: 'posts')
      .orderBy('date', descending: true);

  static getComments(String jobId) => db
      .collection('posts')
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

  Future<QuerySnapshot<Map<String, dynamic>>> search(String tab, String query) {
    return db
        .collection(tab)
        .where('index.${query.toLowerCase()}', isEqualTo: true)
        .limit(25)
        .get();
  }

  Future<DocumentReference<Map<String, dynamic>>> saveComment(
    String postId,
    String comment,
    UserModel user,
  ) {
    var data = {
      'comment': comment,
      'timestamp': Timestamp.now(),
      'commenter': user.first_name + ' ' + user.last_name,
      'commenterUid': user.uid,
      'commenterImage': user.photoURL,
    };
    return db.collection('posts').doc(postId).collection('comments').add(data);
  }

  Future delete(String postId, String commentId) => db
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .doc(commentId)
      .delete();

  static Future addArticle(Article article) {
    return db.collection('posts').add(article.toJson());
  }

  static Future addJob(JobModel job) {
    return db.collection('jobs').add(job.toJson());
  }
}
