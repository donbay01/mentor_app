import 'package:career_paddy/models/notification_model.dart';
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
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            child: Image(
              image: AssetImage('assets/avatar.png'),
            ),
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
                      text: 'Chibuike sent you a',
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
              Text('4:30 PM'),
            ],
          )
        ],
      ),
    );
  }
}
