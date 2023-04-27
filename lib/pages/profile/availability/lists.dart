import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_shift.dart';

class AvailabiltyList extends StatefulWidget {
  final DateTime today;

  const AvailabiltyList({
    super.key,
    required this.today,
  });

  @override
  State<AvailabiltyList> createState() => _AvailabiltyListState();
}

class _AvailabiltyListState extends State<AvailabiltyList> {
  @override
  Widget build(BuildContext context) {
    var prov = context.watch<DateProvider>();
    var size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: AvailabilityService.getAvailableDates(widget.today),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var data = snapshot.data!;
        if (data.size == 0) {
          return AddShift(
            date: widget.today,
            show: true,
            provider: prov,
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
                return Container(
                  decoration: BoxDecoration(color: greyColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: size.height * 0.08,
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
                                    'Free Schedule',
                                    style: small(),
                                  ),
                                ],
                              ),
                              Text(
                                '${shift.start} - ${shift.end}',
                                style: medium(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          AvailabilityService.delete(shift.shiftId);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
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
