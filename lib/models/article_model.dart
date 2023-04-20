import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String author;
  final String viewers;
  final String comments;
  // final Timestamp date;
  // final String articleId;

  Article({
    required this.author,
    required this.viewers,
    required this.comments,
    required this.title,
    required this.description,
    required this.content,
    // required this.date,
    // required this.articleId,
  });
}
