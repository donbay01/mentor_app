import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/models/lesson_model.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CourseOutline extends StatelessWidget {
  final List<LessonModel> outlines;

  const CourseOutline({
    super.key,
    required this.outlines,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: outlines.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var outline = outlines[index];

        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              imageUrl: outline.image,
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
            outline.name,
            style: mediumBold(primaryBlack),
          ),
          subtitle: Text(
            "Lesson ${index + 1}",
            style: small(),
          ),
          onTap: () {},
        );
      },
    );
  }
}
