import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/pages/profile/edit_buddyProfile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../profile/edit_paddyProfile.dart';

class WelcomePage extends StatefulWidget {
  final String role;

  const WelcomePage({
    super.key,
    required this.role,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    var prov = context.read<UserProvider>();
    prov.listenToUser();

    Future.delayed(const Duration(seconds: 3), () {
      // if (widget.role == MENTEE) {
      //   var user = prov.getUser;
      //   return Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (ctx) => EditBuddyProfile(
      //         user: user,
      //       ),
      //     ),
      //     (route) => false,
      //   );
      // }

      return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => EditPaddyProfile()),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = AuthService().getFirebaseUser()!;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: const [primaryBlue, secondaryBlue],
            ),
          ),
          child: Center(
            child: Text(
              'Welcome ${user.displayName}',
              style: largeText(primaryWhite),
            ).animate().slideY().scale().move(
                  delay: 1000.ms,
                  duration: 800.ms,
                ),
          ),
        ),
      ),
    );
  }
}
