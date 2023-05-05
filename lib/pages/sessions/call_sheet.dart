import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../helper/date.dart';
import '../../models/mentor_model.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../notifications/stacked_avatar.dart';
import '../video call/index.dart';

class CallSheet extends StatelessWidget {
  final SessionModel session;
  final UserModel user;
  final String role;



  const CallSheet({
    super.key,
    required this.session,
    required this.user,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var isLive = DateHelper.isLive(
      session.startTimestamp.toDate(),
      session.start,
      session.end,
    );

    bool isDecline = false;


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
                      style: mediumBold(primaryBlack),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){

                          },
                          child: Text (
                            role == Mentor
                                ? 'View Buddy profile'
                                : 'View Paddy Profile',
                            style: smallText(primaryBlue),
                          )
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
                      height: 40,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 43,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                'Cancel',
                                style: mediumBold(Colors.red),
                              )),
                          ElevatedButton(
                            onPressed: () {
                              if (isLive) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => VideoScreen(
                                    channel: session.sessionId,
                                    user: user,
                                    session: session,
                                  ),
                                ));
                              } else {
                                SnackBarHelper.displayToastMessage(
                                  context,
                                  'It is not yet time',
                                  primaryBlue,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Text(
                                'Join now',
                                style: medium(),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                          ),
                        ],
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
