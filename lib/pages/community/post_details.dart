import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/community/comments.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/community.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/article_model.dart';

class ArticleDetailsPage extends StatefulWidget {
  final Article article;

  ArticleDetailsPage({required this.article});

  @override
  _ArticleDetailsPageState createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  var controller = TextEditingController();

  @override
  void initState() {
    CommunityService.view(widget.article.articleId!);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().getUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: primaryBlue,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.article.title,
              style: mediumText(primaryBlue),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.article.title,
                        style: large(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(widget.article.author, style: medium()),
                  SizedBox(height: 16),
                  Text(widget.article.content, style: medium()),
                  SizedBox(
                    height: 20,
                  ),
                  Comments(
                    id: widget.article.articleId!,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter comment....',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await CommunityService().saveComment(
                              widget.article.articleId!,
                              controller.text,
                              user,
                            );
                            controller.text = '';
                            SnackBarHelper.displayToastMessage(
                              context,
                              'Comment delivered',
                              primaryBlue,
                            );
                          },
                          icon: Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
