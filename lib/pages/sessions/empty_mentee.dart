import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/profile/availability/paddy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/bottom_nav.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class EmptyMentee extends StatelessWidget {
  final UserModel user;

  const EmptyMentee({
    super.key,
    required this.user,
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
        Text(
          user.role == MENTOR
              ? 'You have not been booked for any session'
              : 'You have not booked any sessions yet.',
        ),
        if (!user.isAvailabilitySet) ...[
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            // onTap: () => nav.setIndex(1),
            onTap: () {
              user.role == MENTOR
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MentorAvailabilty(),
                      ),
                    )
                  : nav.setIndex(1);
            },
            child: Text(
              user.role == MENTOR ? 'Set availability!' : 'No bookings yet!',
              style: mediumText(primaryBlue),
            ),
          ),
        ],
      ],
    );
  }
}
