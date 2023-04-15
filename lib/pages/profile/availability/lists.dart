import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AvailabiltyList extends StatelessWidget {
  const AvailabiltyList({super.key});

  @override
  Widget build(BuildContext context) {
    var date = context.watch<DateProvider>().selected;
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: AvailabilityService.getAvailableDates(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var data = snapshot.data!;
        if (data.size == 0) {
          return Center(child: Text('No session for this date',style: medium(),));
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
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people),
                            SizedBox(width: 10,),
                            Text('Career Session',style: small(),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Text('${shift.start} - ${shift.end}',style: medium(),),
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
