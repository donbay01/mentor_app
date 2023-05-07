import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'course_details.dart';

class CourseListUI extends StatelessWidget {
  final CourseModel course;

  const CourseListUI({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CachedNetworkImage(
            width: 64,
            height: 64,
            fit: BoxFit.cover,
            imageUrl: course.image,
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
          title: Text(
            course.name,
            style: mediumBold(primaryBlack),
          ),
          subtitle: Text(
            "By ${course.author}",
            style: small(),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CourseDetails(
                  course: course,
                ),
              ),
            );
          },
        ),
        Divider(
          color: darkBlue,
        )
      ],
    );
  }
}
