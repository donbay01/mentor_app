import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_shift.dart';

class AvailabiltyList extends StatelessWidget {
  final DateTime today;

  const AvailabiltyList({
    super.key,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<DateProvider>();
    var date = prov.selected;
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: AvailabilityService.getAvailableDatesFuture(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var data = snapshot.data!;
        if (data.size == 0 || prov.enabled) {
          return AddShift(
            date: today,
            show: true,
          );
        }

        if (data.size > 0) {
          var shifts =
              data.docs.map((e) => Shift.fromJson(e.id, e.data())).toList();
          return Column(
            children: List.generate(
              data.size,
              (index) {
                var shift = shifts[index];
                return Row(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.01,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Career Session',
                              style: small(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${shift.start} - ${shift.end}',
                          style: medium(),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
