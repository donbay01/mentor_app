import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/course_outline.dart';
import 'package:career_paddy/pages/learn/lession_page.dart';
import 'package:career_paddy/pages/learn/lessons_paginated.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';

class CourseDetails extends StatefulWidget {
  final CourseModel course;
  final bool isPreview;

  const CourseDetails({
    Key? key,
    required this.course,
    this.isPreview = false,
  }) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isEnrolled = false;
  var service = CourseService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.read<UserProvider>().getUser;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Learning',
          style: mediumText(primaryBlue),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.course.name,
                style: largeText(primaryBlack),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CachedNetworkImage(
              width: size.width,
              height: size.height * 0.2,
              fit: BoxFit.cover,
              imageUrl: widget.course.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'About the course',
                style: mediumBold(darkBlue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                widget.course.about,
                style: mediumText(textGrey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Skills to gain',
                style: mediumBold(darkBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    widget.course.skills.length,
                    (index) {
                      var skill = widget.course.skills[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              skill,
                              style: mediumText(textGrey),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Course outline',
                style: mediumBold(primaryBlack),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.course.enrolledUids.contains(user.uid)) ...[
              PaginatedLessons(
                course: widget.course,
              ),
            ] else ...[
              CourseOutline(
                outlines: widget.course.outlines,
              ),
            ],
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.isPreview ||
              isEnrolled ||
              widget.course.enrolledUids.contains(user.uid)
          ? null
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () async {
                  await ProgressService.show(context);
                  await service.enroll(widget.course.courseId!);
                  var lesson =
                      await service.getStartLesson(widget.course.courseId!);
                  await ProgressService.hide();
                  setState(() {
                    isEnrolled = true;
                  });
                  SnackBarHelper.displayToastMessage(
                    context,
                    'Enrolled into ${widget.course.name}',
                    primaryBlue,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => LessonPage(
                        course: widget.course,
                        lesson: lesson,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: primaryBlue,
                  ),
                  child: Center(
                    child: Text(
                      'Enroll Now',
                      style: mediumBold(primaryWhite),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
