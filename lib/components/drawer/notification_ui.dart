import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../pages/notifications/notifications.dart';

class NotificationUI extends StatelessWidget {
  const NotificationUI({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Notifications(),
              ),
            );
          },
          icon: Icon(Icons.notifications),
        ),
        if (user.notifications > 0) ...[
          Align(
            alignment: Alignment.topRight,
            child: Badge(
              label: Text('${user.notifications}'),
            ),
          ),
        ],
      ],
    );
  }
}
