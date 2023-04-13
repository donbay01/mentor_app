import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class AboutProfile extends StatelessWidget {
  const AboutProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. Dignissim sit sem mattis aliquet ut sapien mattis aliquet adipiscing.',
          style: mediumText(textGrey),
        ),
        SizedBox(
          height: 20,
        ),
        //Job Experiences
        Text(
          'Experience',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Ux Strategist',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Apple',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Sept 2021 - present',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Ux Researcher',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Layers',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Jan 2021 - August 2021',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'UI Designer',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'carli',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Jan 2021 - August 2021',
          style: smallText(textGrey),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'I can help with',
          style: mediumBold(textGrey),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Career roadmap and advice',
              style: smallText(textGrey),
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 15,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mock Interviews',
              style: smallText(textGrey),
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 15,
            )
          ],
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}
