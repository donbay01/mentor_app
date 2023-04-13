import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/shift.dart';
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
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
      width: 103.67,
      decoration: BoxDecoration(
        color: Color(0xfff2f3f6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateHelper.formatShift(shift.timestamp.toDate()),
            style: small(),
          ),
          Text(
            '${shift.start} - ${shift.end}',
            style: small(),
          ),
        ],
      ),
    );
  }
}
