import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/components/users/book_btn.dart';
import 'package:career_paddy/components/users/shift_ui.dart';
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

  @override
  void initState() {
    prov = context.read<UserProvider>();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        prov.cancelShift();
        return Future.value(true);
      },
      child: Column(
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
                  style: mediumText(primaryBlack),
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
              style: small(),
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
                var shifts = data.docs
                    .map((e) => Shift.fromJson(e.id, e.data()))
                    .toList();

                return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: List.generate(data.size, (index) {
                    var shift = shifts[index];
                    return GestureDetector(
                      onTap: () {
                        prov.setShift(shift);
                        currentShift = shift;
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
            child: Text('Leave a message for your mentor (Optional)',style: smallText(textGrey),),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'What would yoy like from this section',
                hintStyle: smallText(textGrey),
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
                    color: darkBlue,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  prov.cancelShift();
                  Navigator.pop(context);
                },
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffeaecf0)),
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: medium(),
                    ),
                  ),
                ),
              ),
              BookButton(
                mentee: widget.mentee,
                user: widget.user,
                meetingType: widget.meetingType,
                note: controller.text,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
