import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/pages/notifications/empty.dart';
import 'package:career_paddy/pages/notifications/mentee.dart';
import 'package:career_paddy/pages/notifications/mentor.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class SessionNotification extends StatelessWidget {
  const SessionNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var service = AuthService();
    var user = context.watch<UserProvider>().getUser;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  try {
                    await ProgressService.show(context);
                    await service.clearNotifications();
                    await ProgressService.hide();
                  } catch (e) {
                    await ProgressService.hide();
                  }
                },
                child: Text('Clear All',style: smallBold(primaryBlue),),
              ),
            ],
          ),
          PaginateFirestore(
            query: service.getNotifications(),
            initialLoader: const Loader(),
            onEmpty: const EmptyNotification(),
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
        ],
      ),
    );
  }
}
