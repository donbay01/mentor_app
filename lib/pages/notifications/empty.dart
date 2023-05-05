import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.notifications_off,
            size: 60,
            color: primaryBlue,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'No Notification',
            style: small(),
          ),
        ),
      ],
    );
  }
}
