import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/pages/notifications/empty.dart';
import 'package:career_paddy/pages/notifications/mentee.dart';
import 'package:career_paddy/pages/notifications/mentor.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import '../../theme/text_style.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: primaryBlack,
            size: 25,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: primaryBlack, fontSize: 20),
        ),
      ),
      body: PaginateFirestore(
        query: AuthService().getNotifications(),
        initialLoader: const Loader(),
        onEmpty: const EmptyNotification(),
        isLive: true,
        shrinkWrap: true,
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
    );
  }
}
