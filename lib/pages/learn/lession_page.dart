import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class LessonPage extends StatelessWidget {
  final CourseModel course;
  final LessonModel lesson;
  final int number;

  const LessonPage({
    Key? key,
    required this.course,
    required this.lesson,
    this.number = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);

          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
        title: Text(
          course.name,
          style: mediumText(primaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.3,
              imageUrl: lesson.image,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'LESSON ${number + 1}',
                style: mediumBold(primaryBlack),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                lesson.name,
                style: mediumBold(primaryBlack),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                child: Text(
                  lesson.description,
                  style: mediumText(textGrey),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  await ProgressService.show(context);
                  var next = await CourseService.nextLesson(
                    course.courseId!,
                    lesson.lessonId!,
                  );
                  await ProgressService.hide();
                  if (next == null) {
                    SnackBarHelper.displayToastMessage(
                      context,
                      'No more lessons',
                      primaryBlue,
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => LessonPage(
                          course: course,
                          lesson: next,
                          number: number + 1,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Next Lesson',
                  style: mediumBold(primaryBlue),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
