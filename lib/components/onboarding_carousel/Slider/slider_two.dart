// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme/color.dart';
import '../../../theme/text_style.dart';

class Slider2 extends StatelessWidget {
  const Slider2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child:  SvgPicture.asset('assets/mock.svg',
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
                'Career development sessions',
                style: largeText(primaryWhite),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Have one-on-one career sessions with experienced professionals in your field',
            style: mediumText(primaryWhite),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
