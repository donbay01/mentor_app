// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations

import 'dart:async';
import 'package:career_paddy/pages/Authentication/get_started.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  late Box box;

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 3), () {
      context.read<UserProvider>().listenToUser();
      Navigator.of(context).push(
        _createRoute(),
      );
    });
    getBox();
    super.initState();
  }

  getBox() async {
    box = await Hive.openBox('app');
  }

  @override
  void dispose() {
    _timer?.cancel();
    box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          colors: const [primaryBlue, secondaryBlue],
        ),
      ),
      child: Center(
        child: SvgPicture.asset('assets/whiteLogo.svg'),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _getWidget(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _getWidget() {
    var user = AuthService().getFirebaseUser();
    var hasOnboarded = box.get('onboarding') == true;

    if (hasOnboarded && user == null) {
      return const GetStarted();
    }

    if (user != null) {
      return const Dashboard();
    }

    return OnboardingScreen();
  }
}
