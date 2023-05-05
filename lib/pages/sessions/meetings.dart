import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/date.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../profile/availability/paddy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:career_paddy/pages/sessions/session_list.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:career_paddy/helper/date.dart';

class Meetings extends StatefulWidget {
  const Meetings({super.key});

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateHelper.getMonthString(today)} ${today.year}',
                style: mediumText(primaryBlue),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CalendarTimeline(
            initialDate: today,
            firstDate: today,
            lastDate: today.add(
              Duration(days: 7),
            ),
            onDateSelected: (date) {
              dateProvider.setDate(date);
              setState(() {
                today = date;
              });
            },
            leftMargin: 10,
            activeDayColor: Colors.white,
            dayColor: greyText,
            monthColor: greyText,
            activeBackgroundDayColor: primaryBlue,
            dotsColor: Colors.white,
            showYears: false,
            shrink: true,
          ),
          SizedBox(
            height: 20,
          ),
          SessionList(date: today),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const MentorAvailabilty(),
            ),
          );
        },
        child: Container(
          height: size.height * 0.065,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: primaryBlue, width: 1),
            color: primaryBlue,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.calendarCheck,
                  size: 15,
                  color: primaryWhite,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Set availability',style: mediumText(primaryWhite),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
