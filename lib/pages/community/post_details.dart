import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../models/article_model.dart';

class ArticleDetailsPage extends StatefulWidget {
  final Article article;

  ArticleDetailsPage({required this.article});

  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
          onPressed: () {
            // nav.setIndex(2);
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(widget.article.title,style: mediumText(primaryBlue),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.article.title, style: large()),
                  Text('3 Hours ago')
                ],
              ),
              SizedBox(height: 10),
              Text(widget.article.author, style: medium()),
              SizedBox(height: 16),
              Text(widget.article.content, style: medium()),

              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
