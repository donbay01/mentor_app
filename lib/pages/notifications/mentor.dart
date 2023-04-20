import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/pages/notifications/sheet.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorNotification extends StatelessWidget {
  final NotificationModel notification;

  const MentorNotification({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (ctx) => ResponseSheet(
          notification: notification,
        ),
      ),
      child: Row(
        children: [
          if (notification.image != null) ...[
            ProfileIcon(
              image: notification.image,
              isExternal: true,
              radius: 40,
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
      ),
    );
  }
}
