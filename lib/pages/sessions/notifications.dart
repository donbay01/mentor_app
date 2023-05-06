import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/notifications/empty.dart';
import 'package:career_paddy/pages/notifications/mentee.dart';
import 'package:career_paddy/pages/notifications/mentor.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/session.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../../components/drawer/profile_icon.dart';
import '../../helper/date.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class SessionNotification extends StatelessWidget {
  const SessionNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = AuthService();
    var user = context.watch<UserProvider>().getUser;

    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Pending requests',
            style: mediumBold(primaryBlack),
          ),
          SizedBox(
            height: 5,
          ),
          PaginateFirestore(
            query: service.getNotifications(),
            initialLoader: const Loader(),
            onEmpty: Center(
              child: Text(
                'No requests yet',
                style: mediumText(textGrey),
              ),
            ),
            isLive: true,
            shrinkWrap: true,
            separator: const SizedBox(height: 10),
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (context, snapshots, index) {
              var doc = snapshots[index];
              var notification = NotificationModel.fromJson(
                doc.id,
                doc.data() as dynamic,
              );

              return user.role == MENTOR
                  ? MentorNotification(
                      notification: notification,
                    )
                  : MenteeNotification(
                      notification: notification,
                    );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Request History',
            style: mediumBold(primaryBlack),
          ),
          SizedBox(
            height: 5,
          ),
          PaginateFirestore(
            physics: const NeverScrollableScrollPhysics(),
            query: SessionService.getRecentSessions(user.uid),
            initialLoader: const Loader(),
            onEmpty: Center(
              child: Text(
                'No requests yet',
                style: mediumText(textGrey),
              ),
            ),
            isLive: true,
            shrinkWrap: true,
            separator: const SizedBox(height: 10),
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (context, snapshots, index) {
              var doc = snapshots[index];
              var session = SessionModel.fromJson(
                doc.id,
                doc.data() as dynamic,
              );

              return Row(
                children: [
                  ProfileIcon(
                    image: session.menteeImage,
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
                        Text(
                          session.mentee,
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          session.jobRole,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
