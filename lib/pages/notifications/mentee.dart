import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/pages/notifications/sheet.dart';
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
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100),
          ),
        ),
        builder: (ctx) => ResponseSheet(
          notification: notification,
          isMentee: true,
          isAction: false,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProfileIcon(
                image: notification.other_image,
                isExternal: true,
                radius: 50,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: notification.other_image != null
                          ? size.width * 0.7
                          : size.width * 0.95,
                      child: Text(
                        notification.title,
                        // overflow: TextOverflow.ellipsis,
                        style: smallText(primaryBlack),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      DateHelper.formatShort(
                        notification.timestamp.toDate(),
                      ),
                      style: smallText(textGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
