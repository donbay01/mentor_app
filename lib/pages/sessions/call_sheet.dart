import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../helper/date.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../notifications/stacked_avatar.dart';
import '../video call/index.dart';

class CallSheet extends StatelessWidget {
  final SessionModel session;
  final UserModel user;

  const CallSheet({
    super.key,
    required this.session,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    StackedAvatars(
                      mentorImage: session.mentorImage,
                      menteeImage: session.menteeImage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${session.meetingType} with ${session.mentee}',
                      style: mediumText(primaryBlack),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' ${DateHelper.formatMedium(session.requestedAt.toDate())} | ${session.start} - ${session.end}',
                      style: smallText(textGrey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Message',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${session.note}',
                      style: mediumText(primaryBlack),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 43,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => VideoScreen(
                              channel: session.sessionId,
                              user: user,
                              session: session,
                            ),
                          ),
                        ),
                        child: Text('Join now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
