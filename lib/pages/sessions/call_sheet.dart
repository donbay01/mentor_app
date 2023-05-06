import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/profile/buddy_profile.dart';
import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:flutter/material.dart';
import '../../helper/date.dart';
import '../../services/progress.dart';
import '../../services/session.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../notifications/stacked_avatar.dart';
import '../video call/index.dart';

class CallSheet extends StatefulWidget {
  final SessionModel session;
  final UserModel user, mentor;
  final String role;

  const CallSheet({
    super.key,
    required this.session,
    required this.user,
    required this.role,
    required this.mentor,
  });

  @override
  State<CallSheet> createState() => _CallSheetState();
}

class _CallSheetState extends State<CallSheet> {
  bool isDecline = false;
  var controller = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  handle() async {
    await ProgressService.show(context);
    await SessionService.makeDecision(
      'decline',
      widget.session.sessionId,
      null,
      controller.text.isEmpty ? null : controller.text,
    );
    await ProgressService.hide();

    Navigator.of(context).pop();
  }

  send() async {
    try {
      if (isDecline) {
        var isValid = key.currentState?.validate();
        if (isValid!) {
          return handle();
        }
      } else if (!isDecline) {
        return handle();
      }
    } catch (e) {
      await ProgressService.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var isLive = DateHelper.isLive(
      widget.session.startTimestamp.toDate(),
      widget.session.start,
      widget.session.end,
    );

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
                      mentorImage: widget.session.mentorImage,
                      menteeImage: widget.session.menteeImage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.session.meetingType} with ${widget.session.mentee}',
                      style: mediumBold(primaryBlack),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (!isDecline) ...[
                      Text(
                        ' ${DateHelper.formatMedium(widget.session.requestedAt.toDate())} | ${widget.session.start} - ${widget.session.end}',
                        style: smallText(textGrey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (widget.role == MENTOR) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => PaddyProfile(
                                      paddy: widget.mentor,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => BuddyProfile(
                                      buddy: widget.user,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              widget.role == MENTOR
                                  ? 'View Buddy profile'
                                  : 'View Paddy Profile',
                              style: smallText(primaryBlue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.session.note}',
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
                              onPressed: () => setState(() {
                                isDecline = true;
                              }),
                              child: Text(
                                'Cancel',
                                style: mediumBold(Colors.red),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (isLive) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => VideoScreen(
                                      channel: widget.session.sessionId,
                                      user: widget.user,
                                      session: widget.session,
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
                                  horizontal: 25.0,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Join now',
                                  style: medium(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Text(
                        'Reason',
                        style: mediumBold(darkBlue),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kindly state your reason for declining';
                            }
                          },
                          controller: controller,
                          minLines: 2,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Reason for declining invite',
                            hintStyle: smallText(textGrey),
                            suffixIcon: controller.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      controller.clear();
                                    },
                                  ),
                            filled: true,
                            fillColor: primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: darkBlue,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: primaryBlue,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => send(),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                'Decline',
                                style: mediumBold(primaryBlue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
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
