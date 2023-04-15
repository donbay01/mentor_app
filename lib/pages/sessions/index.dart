import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/pages/sessions/session_list.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/date.dart';
import '../../theme/color.dart';
import '../profile/availability/paddy.dart';

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
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Sessions',
              style: largeText(darkBlue),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateHelper.getMonthString(today)} ${today.year}',
                  style: mediumBold(darkBlue),
                ),
                GestureDetector(
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
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.calendarCheck,
                            size: 15,
                            color: secondaryBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Set availability'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CalendarTimeline(
              initialDate: today,
              firstDate: DateTime(today.year, today.month),
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
              dayColor: greyText,
              monthColor: greyText,
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
      ),
    );
  }
}
