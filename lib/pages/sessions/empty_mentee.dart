import 'package:career_paddy/constants/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/bottom_nav.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class EmptyMentee extends StatelessWidget {
  final String role;

  const EmptyMentee({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    var nav = context.read<BottomNavProvider>();

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
        GestureDetector(
          onTap: () => nav.setIndex(1),
          child: Text(
            role == MENTOR ? 'Set availability!' : 'No bookings yet!',
            style: mediumText(primaryBlue),
          ),
        )
      ],
    );
  }
}
