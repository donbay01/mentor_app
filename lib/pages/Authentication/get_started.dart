import 'package:career_paddy/pages/Authentication/register_page.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool mentorCheck = false;
  bool menteeCheck = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: primaryWhite,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                width: 60.4,
                height: 52.58,
                child: SvgPicture.asset('assets/iconLogo.svg'),
              ),
              RichText(
                // getstartedwithcareerpaddyujG (113:4824)
                text: TextSpan(
                  style: medium(),
                  children: [
                    TextSpan(
                        text: 'Get Started with ',
                        style: largeText(primaryBlack)),
                    TextSpan(
                      text: 'Career',
                      style: largeText(secondaryBlue),
                    ),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: 'Paddy',
                      style: largeText(primaryBlue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                width: double.infinity,
                height: 74,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffeaecf0)),
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up as a mentee',
                          style: mediumText(darkBlue),
                        ),
                        Text(
                            // accessmentorsforcareeradviceTJ (I217:4842;217:4643)
                            'Access mentors for career advice',
                            style: mediumText(textGrey)),
                      ],
                    ),
                    Checkbox(
                        value: menteeCheck,
                        onChanged: (newValue) {
                          setState(() {
                            menteeCheck = newValue!;
                          });
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                width: double.infinity,
                height: 74,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffeaecf0)),
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign up as a mentee',
                          style: mediumText(darkBlue),
                        ),
                        Text(
                            // accessmentorsforcareeradviceTJ (I217:4842;217:4643)
                            'Access mentors for career advice',
                            style: mediumText(textGrey)),
                      ],
                    ),
                    Checkbox(
                        value: mentorCheck,
                        onChanged: (newValue1) {
                          setState(() {
                            mentorCheck = newValue1!;
                          });
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: height * 0.06,
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (menteeCheck || mentorCheck == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen()));
                      } else {
                        displayToastMessage('Select an option', primaryBlue);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(320))),
                    child: const Text("Get Started"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  displayToastMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
