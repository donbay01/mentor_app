import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/sessions/call_sheet.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/progress.dart';
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

    var options = Options(format: Format.hex, luminosity: Luminosity.bright);
    var color = RandomColor.getColor(options);

    return GestureDetector(
      onTap: () async {
        await ProgressService.show(context);
        var mentor = await AuthService.getSingleUser(session.mentorUid);
        var mentee = await AuthService.getSingleUser(session.menteeUid);
        await ProgressService.hide();

        await showModalBottomSheet(
          context: context,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              topLeft: Radius.circular(100),
            ),
          ),
          builder: (ctx) => CallSheet(
            session: session,
            user: mentee,
            role: mentor.role,
            mentor: mentor,
          ),
        );
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
                      // if (isLive) ...[
                      //   // SvgPicture.asset('assets/live.svg'),
                      // ],
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
