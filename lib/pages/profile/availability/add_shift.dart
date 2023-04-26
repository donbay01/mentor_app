import 'package:career_paddy/components/buttons/blue.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddShift extends StatefulWidget {
  final DateTime date;
  final bool show;

  const AddShift({
    super.key,
    required this.date,
    this.show = false,
  });

  @override
  State<AddShift> createState() => _AddShiftState();
}

class _AddShiftState extends State<AddShift> {
  String _start = '00:00', _end = '00:30';

  var key = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (int h = 0; h < 24; h++) {
      for (int m = 0; m < 60; m += 30) {
        String hour = h.toString().padLeft(2, '0');
        String minute = m.toString().padLeft(2, '0');
        items.add(DropdownMenuItem(
          value: '$hour:$minute',
          child: Text('$hour:$minute'),
        ));
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<DateProvider>();

    return prov.enabled || widget.show
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
                    value: _start,
                    items: _buildDropdownMenuItems(),
                    onChanged: (String? value) {
                      if (value! == _end) {
                        return SnackBarHelper.displayToastMessage(
                          context,
                          'Start time cannot be the same as end time',
                          primaryBlue,
                        );
                      }

                      setState(() {
                        _start = value;
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
                    value: _end,
                    items: _buildDropdownMenuItems(),
                    onChanged: (String? value) {
                      if (value! == _start) {
                        return SnackBarHelper.displayToastMessage(
                          context,
                          'End time cannot be the same as start time',
                          primaryBlue,
                        );
                      }

                      setState(() {
                        _start = value;
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
                        onTap: () => prov.setEnabled(!prov.enabled),
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
                          if (isValid!) {
                            await AvailabilityService().addDate(
                              widget.date,
                              DateHelper.getTimeOfDayString(_start),
                              DateHelper.getTimeOfDayString(_end),
                            );
                            prov.setEnabled(!prov.enabled);
                            SnackBarHelper.displayToastMessage(
                              context,
                              'Shift added',
                              primaryBlue,
                            );
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
