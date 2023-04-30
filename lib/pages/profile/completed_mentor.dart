import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CompletedProfile extends StatelessWidget {
  const CompletedProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/Success.svg',height: 100,),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Thank you for completing your profile',
              style: mediumBold(primaryBlack),
            ),
          ),
          SizedBox(height: 10,),
          Text('We will notify you when you have been verified!',style: smallText(textGrey),textAlign: TextAlign.center,),

        ],
      ),
    );
  }
}
