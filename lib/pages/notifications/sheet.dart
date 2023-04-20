import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/notification_model.dart';
import 'package:career_paddy/services/session.dart';
import 'package:flutter/material.dart';

class ResponseSheet extends StatefulWidget {
  final NotificationModel notification;

  const ResponseSheet({
    super.key,
    required this.notification,
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          if (!isDecline) ...[
            Text(
              '${widget.notification.meetingType} with ${widget.notification.mentee}',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ' ${DateHelper.formatMedium(widget.notification.shift_date.toDate())} | ${widget.notification.start} - ${widget.notification.end}',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => send(),
                  child: Text('Accept'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      action = 'decline';
                      isDecline = true;
                    });
                  },
                  child: Text('Decline'),
                ),
              ],
            ),
          ] else ...[
            Text('Reason'),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: reason,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Reason for declining invite',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => send(),
                  child: Text('Decline'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
