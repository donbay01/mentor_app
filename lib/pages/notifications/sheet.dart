import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/pages/notifications/stacked_avatar.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../services/progress.dart';
import '../../theme/color.dart';

class ResponseSheet extends StatefulWidget {
  final NotificationModel notification;
  final bool isMentee, isAction;

  const ResponseSheet({
    super.key,
    required this.notification,
    this.isMentee = false,
    this.isAction = true,
  });

  @override
  State<ResponseSheet> createState() => _ResponseSheetState();
}

class _ResponseSheetState extends State<ResponseSheet> {
  bool isDecline = false;
  String action = 'accept';

  final reason = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isMentee) {
      AuthService.readDecline(widget.notification.notificationId);
    }

    super.initState();
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  handle() async {
    await ProgressService.show(context);
    await SessionService.makeDecision(
      action,
      widget.notification.sessionId!,
      widget.notification.notificationId,
      reason.text.isEmpty ? null : reason.text,
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
                    if (!isDecline && !widget.isMentee && widget.isAction) ...[
                      StackedAvatars(
                        mentorImage: widget.notification.image,
                        menteeImage: widget.notification.other_image,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.notification.meetingType} with ${widget.notification.mentee}',
                        style: mediumText(primaryBlack),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.notification.body}',
                        style: smallText(textGrey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' ${DateHelper.formatMedium(widget.notification.shift_date.toDate())} | ${widget.notification.start} - ${widget.notification.end}',
                        style: smallText(textGrey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => send(),
                            child: Text(
                              'Accept',
                              style: mediumText(primaryBlue),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                action = 'decline';
                                isDecline = true;
                              });
                            },
                            child: Text(
                              'Decline',
                              style: mediumText(Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ] else if (isDecline &&
                        !widget.isMentee &&
                        widget.isAction) ...[
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
                          controller: reason,
                          minLines: 2,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Reason for declining invite',
                            hintStyle: smallText(textGrey),
                            suffixIcon: reason.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      reason.clear();
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
                    ] else ...[
                      StackedAvatars(
                        mentorImage: widget.notification.image,
                        menteeImage: widget.notification.other_image,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${widget.notification.title} ',
                        style: mediumText(primaryBlack),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.notification.title !=
                          widget.notification.body) ...[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.notification.body}',
                          style: mediumText(primaryBlack),
                        ),
                      ],
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' ${DateHelper.formatMedium(widget.notification.shift_date.toDate())} | ${widget.notification.start} - ${widget.notification.end}',
                        style: smallText(textGrey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
