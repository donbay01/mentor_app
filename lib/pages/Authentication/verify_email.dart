import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'login_page.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 40,
              ),
              Center(
                  child: SvgPicture.asset('assets/iconLogo.svg',height: 100,width: 100,)
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'We have sent a link to your email to confirm your email.',
                  style: small(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Didn't receive an email?",
                  style: mediumText(darkBlue),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Check your spam or junk. It goes there sometimes!',
                  style: small(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // canResendEmail ? sendVerificationEmail() : null;
                },
                icon: const Icon(
                  Icons.email,
                  color: primaryWhite,
                ),
                label: Text(
                  'Resend Email',
                  style: mediumText(primaryWhite),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: primaryBlue,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                  )
                ),
              ),
              TextButton(
                onPressed: () {
                  // service!.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                        (route) => false,
                  );
                },
                child: Text(
                  'Cancel',
                  style: medium(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
