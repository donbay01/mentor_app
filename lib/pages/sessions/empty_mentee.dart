import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class EmptyMentee extends StatelessWidget {
  const EmptyMentee({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/noBookings.svg',
          height: 150,
          width: 150,
          // fit: BoxFit.cover,
        ),
        Text('You have not booked any sessions yet.'),
        SizedBox(
          height: 10,
        ),
        Text(
          'Start booking now!',
          style: smallBold(primaryBlue),
        )
      ],
    );
  }
}
