import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/community.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  save() async {
    try {
      var user = AuthService().getFirebaseUser()!;

      var post = Article(
        author: user.displayName!,
        viewers: 0,
        comments: 0,
        title: titleController.text,
        description: postController.text,
        content: postController.text,
        date: Timestamp.now(),
        authorUid: user.uid,
      );

      await CommunityService.addArticle(post);
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      SnackBarHelper.displayToastMessage(context, e.message!, primaryBlue);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
        title: Text(
          'Community',
          style: mediumText(primaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Write Post',
                    style: large(),
                  ),
                  ElevatedButton(
                    onPressed: save,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Post',
                        style: mediumBold(primaryWhite),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Post title',
                  hintStyle: smallText(textGrey),
                  suffixIcon: titleController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            titleController.clear();
                          },
                        ),
                  filled: true,
                  fillColor: primaryWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: darkBlue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: postController,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'What do you have for us today?',
                  hintStyle: smallText(textGrey),
                  suffixIcon: postController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            postController.clear();
                          },
                        ),
                  filled: true,
                  fillColor: primaryWhite,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: darkBlue,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: primaryBlue,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'max 2000 words',
                    style: smallText(textGrey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
