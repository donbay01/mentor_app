import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    context.read<UserProvider>().listenToUser();

    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => Dashboard()),
        (route) => false,
      ),
    );
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
              'Welcome ${user.displayName}',style: largeText(primaryWhite),
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
