import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/color.dart';

class BecomePaddy extends StatelessWidget {
  const BecomePaddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          ' Become A Paddy',
          style: mediumBold(primaryBlack),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlack,
            size: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Icon(
              FontAwesomeIcons.peopleGroup,
              size: 60,
              color: primaryBlue,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
                  'Become a Paddy',
                  style: mediumBold(primaryBlue),
                )),
            SizedBox(
              height: 20,
            ),
            Text('A Paddy is an industry expert that guides young professionals on their  career journey.'
                '\nEarn money by getting booked for career sections and mock interviews today!',
            style: medium(),textAlign: TextAlign.center,),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Send Paddy Request',
                    style: mediumBold(primaryWhite),
                  ),
                ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue
              ),
            )
          ],
        ),
      ),
    );
  }
}
