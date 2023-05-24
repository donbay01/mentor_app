import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String author;
  final int viewers;
  final int comments;
  final Timestamp date;
  final String? articleId;
  final String authorUid;
  final bool isAccepted;

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'authorUid': authorUid,
        'description': description,
        'content': content,
        'viewers': viewers,
        'comments': comments,
        'date': date,
        'articleId': articleId,
        'indexed': false,
        'type': 'posts',
        'isAccepted': false,
      };

  Article.fromJson(String docId, Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        date = json['date'],
        content = json['content'],
        author = json['author'],
        viewers = json['viewers'],
        comments = json['comments'],
        authorUid = json['authorUid'],
        isAccepted = json['isAccepted'],
        articleId = docId;

  Article({
    required this.author,
    required this.viewers,
    required this.comments,
    required this.title,
    required this.description,
    required this.content,
    required this.date,
    this.articleId,
    required this.authorUid,
    this.isAccepted = false,
  });
}
