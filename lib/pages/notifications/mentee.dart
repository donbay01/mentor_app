import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:flutter/material.dart';
import '../../helper/date.dart';
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
        if (notification.other_image != null) ...[
          ProfileIcon(
            image: notification.other_image,
            isExternal: true,
            radius: 60,
          ),
        ],
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: smallText(primaryBlack),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              DateHelper.formatShort(
                notification.timestamp.toDate(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
