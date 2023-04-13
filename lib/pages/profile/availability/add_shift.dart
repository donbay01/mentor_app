import 'package:career_paddy/components/buttons/blue.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddShift extends StatefulWidget {
  final DateTime date;

  const AddShift({
    super.key,
    required this.date,
  });

  @override
  State<AddShift> createState() => _AddShiftState();
}

class _AddShiftState extends State<AddShift> {
  var start = TextEditingController();
  var end = TextEditingController();

  @override
  void dispose() {
    start.dispose();
    end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<DateProvider>();

    return prov.enabled
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
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
                Text('Start Time'),
                TextFormField(
                  controller: start,
                  onTap: () async {
                    var time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    start.text = time!.format(context);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text('End Time'),
                TextFormField(
                  controller: end,
                  onTap: () async {
                    var time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    end.text = time!.format(context);
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
                        await AvailabilityService().addDate(
                          widget.date,
                          start.text,
                          end.text,
                        );
                        prov.setEnabled(!prov.enabled);
                        SnackBarHelper.displayToastMessage(
                          context,
                          'Shift added',
                          primaryBlue,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
