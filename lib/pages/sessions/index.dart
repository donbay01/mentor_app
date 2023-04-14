import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:career_paddy/pages/sessions/session_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/date.dart';
import '../../theme/color.dart';

class MySessions extends StatefulWidget {
  const MySessions({super.key});

  @override
  State<MySessions> createState() => _MySessionsState();
}

class _MySessionsState extends State<MySessions> {
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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Sessions',
          ),
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
              setState(() {
                today = date;
              });
            },
            leftMargin: 10,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryBlue,
            dotsColor: Colors.white,
            showYears: false,
          ),
          SizedBox(
            height: 20,
          ),
          SessionList(date: today),
        ],
      ),
    );
  }
}
