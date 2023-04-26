import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class ShiftUI extends StatelessWidget {
  final Shift shift;

  const ShiftUI({
    super.key,
    required this.shift,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: Color(0xfff2f3f6),
          borderRadius: BorderRadius.circular(4),
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
  }
}
