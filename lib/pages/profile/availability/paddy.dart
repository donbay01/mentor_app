import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:career_paddy/pages/profile/availability/add_shift.dart';
import 'package:career_paddy/pages/profile/availability/lists.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MentorAvailabilty extends StatefulWidget {
  const MentorAvailabilty({super.key});

  @override
  State<MentorAvailabilty> createState() => _MentorAvailabiltyState();
}

class _MentorAvailabiltyState extends State<MentorAvailabilty> {
  bool isEnabled = false;
  late DateProvider dateProvider;
  late DateTime today;

  @override
  void initState() {
    dateProvider = context.read<DateProvider>();
    today = dateProvider.today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My sessions'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            CalendarTimeline(
              initialDate: today,
              firstDate: today,
              lastDate: today.add(
                Duration(days: 365),
              ),
              onDateSelected: (date) {
                dateProvider.setDate(date);
                dateProvider.setEnabled(!isEnabled);
                setState(() {
                  today = date;
                  isEnabled = !isEnabled;
                });
              },
              leftMargin: 10,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: primaryBlue,
              dotsColor: Colors.white,
              showYears: false,
            ),
            if (dateProvider.enabled) ...[
              AddShift(
                date: today,
              ),
            ],
            SizedBox(
              height: 20,
            ),
            AvailabiltyList(),
          ],
        ),
      ),
    );
  }
}
