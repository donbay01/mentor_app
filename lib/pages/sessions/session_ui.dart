import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/video%20call/index.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:hexcolor/hexcolor.dart';
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
      session.startTimestamp.toDate(),
      session.start,
      session.end,
    );

    var options = Options(format: Format.hex, luminosity: Luminosity.bright);
    var color = RandomColor.getColor(options);

    return GestureDetector(
      onTap: () {
        if (isLive) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => VideoScreen(
                channel: session.sessionId,
                user: user,
                session: session,
              ),
            ),
          );
        } else {
          SnackBarHelper.displayToastMessage(
            context,
            'It is not yet time',
            primaryBlue,
          );
        }
      },
      child: Container(
        color: greyColor,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: size.width * 0.005,
                color: HexColor(color),
              ),
              SizedBox(
                width: 7,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateHelper.formatRelative(
                      session.endTimestamp.toDate(),
                    ),
                  ),
                  Text(
                    '${session.meetingType} with ${name}',
                    style: small(),
                  ),
                  SizedBox(
                    height: 5,
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
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
