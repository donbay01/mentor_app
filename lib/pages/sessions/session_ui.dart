import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
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
    var size = MediaQuery.of(context).size;

    var isLive = DateHelper.isLive(
      session.requestedAt.toDate(),
      session.start,
      session.end,
    );

    return Container(
      color: greyColor,
      child: Row(
        children: [
          Container(
            height: size.height * 0.065,
            width: size.width * 0.01,
            color: Colors.orange,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                DateHelper.formatRelative(
                  session.requestedAt.toDate(),
                ),
              ),
              Text(
                '${session.meetingType} with ${name}',
                style: small(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${session.start} - ${session.end}',
                    style: medium(),
                  ),
                  if (isLive) ...[
                    // SvgPicture.asset('assets/live.svg'),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
