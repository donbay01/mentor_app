import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/text_style.dart';

class ShiftUI extends StatelessWidget {
  final Shift shift;
  final Shift? currentShift;

  const ShiftUI({
    super.key,
    required this.shift,
    this.currentShift,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            // width: MediaQuery.of(context).size.width * 0.25,
            // height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: shift.isAvailable ? Color(0xfff2f3f6) : Color(0xFF475467).withOpacity(0.25),
              borderRadius: BorderRadius.circular(4),
              border: shift.shiftId == value.shift?.shiftId
                  ? Border.all(
                      color: primaryBlue,
                      width: 0.9,
                    )
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateHelper.formatShift(shift.timestamp.toDate()),
                  style: smallBold(primaryBlack),
                ),
                Text(
                  '${shift.start} - ${shift.end}',
                  style: smallText(textGrey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
