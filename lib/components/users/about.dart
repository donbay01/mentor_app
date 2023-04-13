import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/components/users/shift_ui.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/services/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class About extends StatefulWidget {
  final UserModel user, mentee;

  const About({
    super.key,
    required this.user,
    required this.mentee,
  });

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Shift? currentShift;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Availability',
                style: small(),
              ),
              SizedBox(
                width: 20,
              ),
              Text('(this week)', style: small()),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Select one date you are comfortable with',
            style: small(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
          stream: AvailabilityService.getUserAvailableDates(widget.user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }

            if (snapshot.hasData) {
              var data = snapshot.data!;
              var shifts =
                  data.docs.map((e) => Shift.fromJson(e.id, e.data())).toList();

              return GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: List.generate(data.size, (index) {
                  var shift = shifts[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentShift = shift;
                      });
                    },
                    child: ShiftUI(shift: shift),
                  );
                }),
              );
            }

            return SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: size.width * 0.45,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffeaecf0)),
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: medium(),
                  ),
                ),
              ),
            ),
            if (currentShift != null) ...[
              GestureDetector(
                onTap: () async {
                  try {
                    await SessionService.bookSession(
                      widget.user,
                      widget.mentee,
                      currentShift!,
                    );
                    Navigator.of(context).pop();
                    SnackBarHelper.displayToastMessage(
                      context,
                      'Appointment request sent',
                      primaryBlue,
                    );
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
              ),
            ],
          ],
        ),
      ],
    );
  }
}
