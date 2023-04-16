import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/user_experience.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class Experiences extends StatelessWidget {
  final List<UserExperience> experiences;

  const Experiences({
    super.key,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: experiences.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var experience = experiences[index];
        var start = experience.start.toDate();
        var end = experience.end.toDate();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              experience.jobRole,
              style: mediumBold(darkBlue),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              experience.company,
              style: smallText(textGrey),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${DateHelper.getMonthString(start)}  ${start.year} - ${DateHelper.getMonthString(end)}  ${end.year}',
              style: smallText(textGrey),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
