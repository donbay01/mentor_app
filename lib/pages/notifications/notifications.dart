import 'package:career_paddy/pages/notifications/empty.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
        onEmpty: const EmptyNotification(),
        isLive: true,
        shrinkWrap: true,
        itemBuilderType: PaginateBuilderType.listView,
        itemBuilder: (context, snapshots, index) {
          var doc = snapshots[index];

          return Text(doc.id);
        },
      ),
    );
  }
}
