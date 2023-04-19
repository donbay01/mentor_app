import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MenteeNotification extends StatelessWidget {
  final NotificationModel notification;

  const MenteeNotification({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/adaptLogo.png'),
          radius: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Isaac accepted your',
                    style: smallText(primaryBlack),
                  ),
                  TextSpan(
                    text: ' career session request',
                    style: smallText(primaryBlue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('12:30 PM'),
          ],
        )
      ],
    );
  }
}
