import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/payment/payment_screen.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/message.dart';
import '../../helper/snackbar.dart';
import '../../services/session.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class BookButton extends StatelessWidget {
  final UserModel mentee, user;
  final String meetingType;
  final String note;
  final String role;

  const BookButton({
    super.key,
    required this.mentee,
    required this.user,
    required this.meetingType,
    required this.note,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<UserProvider>();
    var currentShift = prov.shift;

    return currentShift != null
        ? GestureDetector(
            onTap: () async {
              prov.clearMentorNote();

              try {
                if (mentee.interviews > 0 && meetingType != CAREER_SESSION) {
                  await SessionService.bookSession(
                    user,
                    mentee,
                    currentShift,
                    meetingType,
                    note,
                    role,
                  );
                  Navigator.of(context).pop();
                  SnackBarHelper.displayToastMessage(
                    context,
                    'Appointment request sent',
                    primaryBlue,
                  );
                } else if (mentee.sessions > 0 &&
                    meetingType == CAREER_SESSION) {
                  await SessionService.bookSession(
                    user,
                    mentee,
                    currentShift,
                    meetingType,
                    note,
                    role,
                  );
                  Navigator.of(context).pop();
                  SnackBarHelper.displayToastMessage(
                    context,
                    'Appointment request sent',
                    primaryBlue,
                  );
                } else if (mentee.free_paddy_points > 0) {
                  await SessionService.bookSession(
                    user,
                    mentee,
                    currentShift,
                    meetingType,
                    note,
                    role,
                  );
                  Navigator.of(context).pop();
                  SnackBarHelper.displayToastMessage(
                    context,
                    'Appointment request sent',
                    primaryBlue,
                  );
                } else {
                  SnackBarHelper.displayToastMessage(
                    context,
                    'You do not have enough points for ${meetingType}',
                    primaryBlue,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SubscriptionPage(
                        user: mentee,
                      ),
                    ),
                  );
                }
              } on FirebaseException catch (e) {
                Navigator.of(context).pop();
                SnackBarHelper.displayToastMessage(
                  context,
                  e.message!,
                  primaryBlue,
                );
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffeaecf0)),
                color: primaryBlue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  'Book Now',
                  style: mediumText(primaryWhite),
                ),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
