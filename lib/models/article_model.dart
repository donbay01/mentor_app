import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String author;
  final int viewers;
  final int comments;
  final Timestamp date;
  final String articleId;
  final String authorUid;

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        date = json['date'],
        content = json['content'],
        author = json['author'],
        viewers = json['viewers'],
        comments = json['comments'],
        authorUid = json['authorUid'],
        articleId = json['articleId'];

  Article({
    required this.author,
    required this.viewers,
    required this.comments,
    required this.title,
    required this.description,
    required this.content,
    required this.date,
    required this.articleId,
    required this.authorUid,
  });
}
