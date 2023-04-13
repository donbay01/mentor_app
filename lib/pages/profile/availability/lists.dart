import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailabiltyList extends StatelessWidget {
  const AvailabiltyList({super.key});

  @override
  Widget build(BuildContext context) {
    var date = context.watch<DateProvider>().selected;

    return StreamBuilder(
      stream: AvailabilityService.getAvailableDates(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var data = snapshot.data!;
        if (data.size == 0) {
          return Text('No schedule for this date');
        }

        if (data.size > 0) {
          var shifts =
              data.docs.map((e) => Shift.fromJson(e.id, e.data())).toList();
          return Column(
            children: List.generate(
              data.size,
              (index) {
                var shift = shifts[index];
                return Text('${shift.start} - ${shift.end}');
              },
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
