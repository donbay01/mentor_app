import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/color.dart';
import '../../../theme/text_style.dart';

class Slider3 extends StatelessWidget {
  const Slider3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child:  SvgPicture.asset('assets/consult.svg',
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
                'Mock interviews',
                style: largeText(primaryWhite),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Get yourself ready for your next interview with one of our Career Paddies.',
            style: mediumText(primaryWhite),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
