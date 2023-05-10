import 'package:career_paddy/pages/notifications/stacked_avatar.dart';
import 'package:career_paddy/pages/sessions/call_sheet.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../constants/role.dart';
import '../../helper/date.dart';
import '../../models/session_model.dart';
import '../../providers/user.dart';
import '../../services/progress.dart';
import '../../theme/text_style.dart';

class SessionPageUI extends StatelessWidget {
  final SessionModel session;

  const SessionPageUI({
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
            role: user.role,
            mentor: mentor,
          ),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateHelper.getAM(
                      session.startTimestamp.toDate(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    DateHelper.getAM(
                      session.endTimestamp.toDate(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                color: Colors.transparent,
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
                            width: 20,
                          ),
                          Row(
                            children: [
                              StackedAvatars(
                                menteeImage: session.menteeImage,
                                mentorImage: session.mentorImage,
                                height: 30,
                                width: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Session with ${name}',
                                style: small(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                '${session.start} - ${session.end}',
                                style: small(),
                              ),
                              if (isLive) ...[
                                // SvgPicture.asset('assets/live.svg'),
                              ],
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
