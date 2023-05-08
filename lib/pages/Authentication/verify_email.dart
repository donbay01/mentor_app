import 'dart:async';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/Authentication/welcome.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/pages/profile/edit_paddyProfile.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
      (timer) => handleCompletion(timer),
    );
    super.initState();
  }

  handleCompletion(Timer timer) async {
    var user = service.getFirebaseUser()!;
    await user.reload();

    if (user.emailVerified) {
      var user = context.read<UserProvider>().getUser;
      timer.cancel();

      // if (user.role == MENTOR && !user.reviewed) {
      //   return Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => EditPaddyProfile(),
      //     ),
      //     (route) => false,
      //   );
      // }

      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(
            role: user.role,
          ),
        ),
        (route) => false,
      );
    }
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
                  child: Icon(
                Icons.mail,
                color: primaryBlue,
                size: 90,
              )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'We have sent a link to your email to confirm your email.',
                  style: smallText(textGrey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Didn't receive an email?",
                  style: smallText(textGrey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
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
