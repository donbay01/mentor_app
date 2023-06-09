import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/color.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  _sendEmail() async {
    launch("mailto:communications@careerpaddy.co");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Contact Us',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            FontAwesomeIcons.envelopesBulk,
            size: 60,
            color: primaryBlue,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            'Send us a mail for assistance',
            style: mediumText(textGrey),
          )),
          SizedBox(
            height: 5,
          ),
          TextButton(
              onPressed: () {
                _sendEmail();
              },
              child: Text(
                'communications@careerpaddy.co',
                style: medium(),
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _sendEmail();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contact Us',
                  style: mediumBold(primaryWhite),
                ),
              ),
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue
            ),
          )
        ],
      ),
    );
  }
}
