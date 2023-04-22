import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String comment;
  final Timestamp timestamp;
  final String commenter;
  final String commenterUid;
  final String commentId;
  final String? commenterImage;

  CommentModel.fromJson(String docId, Map<String, dynamic> json)
      : comment = json['comment'],
        timestamp = json['timestamp'],
        commenter = json['commenter'],
        commenterUid = json['commenterUid'],
        commentId = docId,
        commenterImage = json['commenterImage'];

  CommentModel({
    required this.comment,
    required this.timestamp,
    required this.commenter,
    required this.commenterUid,
    required this.commentId,
    this.commenterImage,
  });
}
