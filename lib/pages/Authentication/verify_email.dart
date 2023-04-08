import 'dart:async';

import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  AuthService service = AuthService();

  @override
  void initState() {
    Timer.periodic(
      const Duration(milliseconds: 2500),
      (timer) async {
        var user = service.getFirebaseUser()!;
        await user.reload();
        if (user.emailVerified) {
          timer.cancel();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

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
                  child: SvgPicture.asset(
                'assets/iconLogo.svg',
                height: 100,
                width: 100,
              )),
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
                onPressed: () async {
                  try {
                    await AuthService()
                        .getFirebaseUser()!
                        .sendEmailVerification();
                    SnackBarHelper.displayToastMessage(
                      context,
                      'Email Sent',
                      primaryBlue,
                    );
                  } on FirebaseAuthException catch (e) {
                    SnackBarHelper.displayToastMessage(
                      context,
                      e.message!,
                      primaryBlue,
                    );
                  }
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
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await service.logout();
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
