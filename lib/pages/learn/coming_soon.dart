import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Learning",
                  style: largeText(primaryBlack),
                ),
                SizedBox(
                  height: 60,
                ),
                Image(image: AssetImage('assets/comingSoon.png')),
                SizedBox(
                  height: 20,
                ),
                Text('Coming soon!',style: largeText(primaryBlack),),
                SizedBox(
                  height: 20,
                ),
                Text('Learn workspace soft skills to get you ahead in your career. Join webinars with industry experts ',
                  style: mediumText(primaryBlack),
                textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
