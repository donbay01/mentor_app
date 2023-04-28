import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';

class ResponseSheet extends StatefulWidget {
  final NotificationModel notification;
  final bool isMentee;

  const ResponseSheet({
    super.key,
    required this.notification,
    this.isMentee = false,
  });

  @override
  State<ResponseSheet> createState() => _ResponseSheetState();
}

class _ResponseSheetState extends State<ResponseSheet> {
  bool isDecline = false;
  String action = 'accept';

  final reason = TextEditingController();

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }

  send() {
    SessionService.makeDecision(
      action,
      widget.notification.sessionId!,
      widget.notification.notificationId,
      reason.text.isEmpty ? null : reason.text,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isDecline && !widget.isMentee) ...[
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/callAvi.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
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
              style: mediumText(primaryBlack),
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
          ] else if (isDecline && !widget.isMentee) ...[
            Text('Reason',style: mediumBold(darkBlue),),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: TextFormField(
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
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/callAvi.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.notification.title} ',
              style: mediumText(primaryBlack),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.notification.body}',
              style: mediumText(primaryBlack),
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
          ],
        ],
      ),
    );
  }
}
