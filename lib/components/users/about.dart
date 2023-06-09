import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/components/users/shift_ui.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/shift.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class About extends StatefulWidget {
  final UserModel user, mentee;
  final String meetingType;

  const About({
    super.key,
    required this.user,
    required this.mentee,
    required this.meetingType,
  });

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Shift? currentShift;
  late UserProvider prov;
  var controller = TextEditingController();
  var mockController = TextEditingController();

  @override
  void initState() {
    prov = context.read<UserProvider>();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    mockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Availability',
                style: mediumBold(primaryBlack),
              ),
              SizedBox(
                width: 5,
              ),
              Text('(this week)', style: smallText(textGrey)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Select one date you are comfortable with',
            style: smallText(textGrey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
          stream: AvailabilityService.getUserAvailableDates(widget.user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }

            if (snapshot.hasData) {
              var data = snapshot.data!;
              var shifts =
                  data.docs.map((e) => Shift.fromJson(e.id, e.data())).toList();

              return GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data.size, (index) {
                  var shift = shifts[index];
                  return GestureDetector(
                    onTap: () {
                      if (shift.isAvailable) {
                        currentShift = shift;
                        prov.setShift(shift);
                      } else {
                        SnackBarHelper.displayToastMessage(
                          context,
                          'This date has been booked',
                          primaryBlue,
                        );
                      }
                    },
                    child: ShiftUI(
                      shift: shift,
                      currentShift: currentShift,
                    ),
                  );
                }),
              );
            }

            return SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Job Role (Optional)',
            style: smallText(textGrey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            onTap: () => prov.setShift(currentShift!),
            controller: mockController,
            onChanged: (value) => prov.setRole(value),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Eg Data Analyst',
              hintStyle: smallText(searchGrey),
              isDense: true,
              suffixIcon: controller.text.isEmpty
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller.clear();
                      },
                    ),
              filled: true,
              fillColor: primaryWhite,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: searchGrey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Leave a message for your paddy (Optional)',
            style: smallText(textGrey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            onTap: () => prov.setShift(currentShift!),
            onChanged: (value) => prov.setNote(value),
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'What would you like from this session',
              hintStyle: smallText(searchGrey),
              isDense: true,
              suffixIcon: controller.text.isEmpty
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller.clear();
                      },
                    ),
              filled: true,
              fillColor: primaryWhite,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: searchGrey,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
