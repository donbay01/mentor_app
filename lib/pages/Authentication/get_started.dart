import 'package:career_paddy/components/card/option.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
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
                      style: largeText(primaryBlack),
                    ),
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
              CardOption(
                title: 'Sign up as a mentee',
                subtitle: 'Access mentors for career advice',
                value: menteeCheck,
                function: () => setState(() {
                  menteeCheck = !menteeCheck;
                  mentorCheck = false;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              CardOption(
                title: 'Sign up as a mentee',
                subtitle: 'Access mentors for career advice',
                value: mentorCheck,
                function: () => setState(() {
                  mentorCheck = !mentorCheck;
                  menteeCheck = false;
                }),
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
                          builder: (_) => RegisterScreen(
                            role: menteeCheck == true ? MENTEE : MENTOR,
                          ),
                        ),
                      );
                    } else {
                      SnackBarHelper.displayToastMessage(
                        context,
                        'Select an option',
                        primaryBlue,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(320),
                    ),
                  ),
                  child: const Text("Get Started"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
