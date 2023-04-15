import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class UserServices extends StatelessWidget {
  const UserServices({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: mediumBold(darkBlue),
        ),
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: greyColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Services of mentor
                    Text(
                      'Ux research',
                      style: smallText(textGrey),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 20,),
              Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: greyColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UI Design',
                      style: smallText(textGrey),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.05,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: greyColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Problem solving',
                      style: smallText(textGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
