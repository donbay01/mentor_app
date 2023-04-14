import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SessionUI extends StatelessWidget {
  final SessionModel session;

  const SessionUI({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().getUser;
    var name = user.role == MENTOR ? session.mentee : session.mentor;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${session.meetingType} with ${name}'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${session.start} - ${session.end}'),
                SvgPicture.asset('assets/live.svg'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
