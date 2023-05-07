import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:career_paddy/pages/learn/lession_page.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class PaginatedLessons extends StatelessWidget {
  final CourseModel course;

  const PaginatedLessons({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      shrinkWrap: true,
      itemBuilder: (context, snapshot, index) {
        var snap = snapshot[index];
        var lesson = LessonModel.fromJson(
          snap.id,
          snap.data() as dynamic,
        );

        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              imageUrl: lesson.image,
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
          ),
          title: Text(
            lesson.name,
            style: mediumBold(primaryBlack),
          ),
          subtitle: Text(
            "Lesson ${index + 1}",
            style: small(),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => LessonPage(
                course: course,
                lesson: lesson,
                number: index,
              ),
            ),
          ),
        );
      },
      query: CourseService.getLessons(course.courseId!),
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}
