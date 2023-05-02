// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/color.dart';

class Slider1 extends StatelessWidget {
  const Slider1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              // width: MediaQuery.of(context).size.width * 0.65,
              child: SvgPicture.asset('assets/learn.svg',
                height: 250,
                fit: BoxFit.cover,)
          ),
          SizedBox(
            height: 30,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confused about job roles?',
                style: largeText(primaryWhite),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Break through the noise and get specific advice on your career challenges',
            style: mediumText(primaryWhite),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
