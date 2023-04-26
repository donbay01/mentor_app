import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:career_paddy/pages/profile/availability/lists.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
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
  void deactivate() {
    // dateProvider.setEnabled(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
          centerTitle: false,
          title: Text(
            'My Schedule',
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
                Text("Set your availability of the week",style: smallText(primaryBlack),),
                SizedBox(
                  height: 20,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          dateProvider.setEnabled(!dateProvider.enabled),
                      child: Text('Add Session'),
                    ),
                  ],
                ),
                // if (dateProvider.enabled) ...[
                //   AddShift(
                //     date: today,
                //   ),
                // ],
                SizedBox(
                  height: 20,
                ),
                AvailabiltyList(
                  today: today,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
