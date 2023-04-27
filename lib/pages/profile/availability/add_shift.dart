import 'package:career_paddy/components/buttons/blue.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_progress_indicator/overlay_progress_indicator.dart';

class AddShift extends StatefulWidget {
  final DateTime date;
  final bool show;
  final DateProvider provider;
  final bool isDialog;

  const AddShift({
    super.key,
    required this.date,
    required this.provider,
    this.show = false,
    this.isDialog = false,
  });

  @override
  State<AddShift> createState() => _AddShiftState();
}

class _AddShiftState extends State<AddShift> {
  var key = GlobalKey<FormState>();
  String _start = '00:00', _end = '00:30';

  List<String> generateTimeList() {
    List<String> timeList = [];
    DateTime now = DateTime.now();
    DateTime currentHour = DateTime(now.year, now.month, now.day,
        widget.date.isAfter(now) ? widget.date.hour : now.hour);
    final format = DateFormat.jm();

    while (currentHour.isBefore(DateTime(now.year, now.month, now.day, 24))) {
      timeList.add(format.format(currentHour));
      currentHour = currentHour.add(Duration(minutes: 30));
    }

    return timeList;
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  @override
  void initState() {
    var t = generateTimeList();
    _start = t.first;
    _end = t[1];

    super.initState();
  }

  close() {
    if (widget.isDialog) {
      return Navigator.pop(context);
    }

    return widget.provider.setEnabled(!widget.provider.enabled);
  }

  @override
  Widget build(BuildContext context) {
    return widget.provider.enabled || widget.show
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: DateHelper.formatDate(widget.date),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Start Time',
                    style: medium(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: textGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 0.5,
                          color: textGrey,
                        ),
                      ),
                    ),
                    value: _start,
                    items: generateTimeList()
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _start = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'End Time',
                    style: medium(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: textGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 0.5,
                          color: textGrey,
                        ),
                      ),
                    ),
                    value: _end,
                    items: generateTimeList()
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _end = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: close,
                        child: Text('Cancel'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      BlueButton(
                        widget: Text('Save'),
                        radius: 50,
                        function: () async {
                          var isValid = key.currentState?.validate();
                          var a1 = DateHelper.getTimeOfDay(_start);
                          var a2 = DateHelper.getTimeOfDay(_end);

                          var t1 = DateHelper.formatTimeOfDay(a1);
                          var t2 = DateHelper.formatTimeOfDay(a2);

                          var s = toDouble(a1);
                          var e = toDouble(a2);

                          bool isEqual = s == e;

                          if (isValid!) {
                            if (isEqual) {
                              return SnackBarHelper.displayToastMessage(
                                context,
                                'End time cannot be the same as start time',
                                primaryBlue,
                              );
                            }

                            if (s > e) {
                              return SnackBarHelper.displayToastMessage(
                                context,
                                'End time cannot be earlier than the start time',
                                primaryBlue,
                              );
                            }

                            await ProgressService.show(context);
                            await AvailabilityService().addDate(
                              widget.date,
                              t1,
                              t2,
                            );
                            await ProgressService.hide();
                            close();
                            // prov.setEnabled(!prov.enabled);
                            // SnackBarHelper.displayToastMessage(
                            //   context,
                            //   'Shift added',
                            //   primaryBlue,
                            // );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
