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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryBlack,
            size: 25,
          ),
        ),
        title: Text(
          'My Sessions',
          style: TextStyle(color: primaryBlack, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CalendarTimeline(
                shrink: true,
                initialDate: today,
                firstDate: today,
                lastDate: today.add(
                  Duration(days: 365),
                ),
                onDateSelected: (date) {
                  dateProvider.setDate(date);
                  // dateProvider.setEnabled(!isEnabled);
                  setState(() {
                    today = date;
                    isEnabled = !isEnabled;
                  });
                },
                leftMargin: 10,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: primaryBlue,
                monthColor: textGrey,
                dotsColor: Colors.white,
                dayColor: greyText,
                showYears: false,
              ),
              SizedBox(
                height: 10,
              ),
              if (dateProvider.enabled) ...[
                AddShift(
                  date: today,
                ),
              ],
              SizedBox(
                height: 40,
              ),
              // AvailabiltyList(
              //   today: today,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
