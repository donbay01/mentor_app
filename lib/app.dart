import 'package:career_paddy/pages/onboarding_screen/onboarding_screen.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/link.service.dart';
import 'package:flutter/material.dart';
import 'package:career_paddy/pages/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class CareerPaddy extends StatefulWidget {
  const CareerPaddy({Key? key}) : super(key: key);

  @override
  State<CareerPaddy> createState() => _CareerPaddyState();
}

class _CareerPaddyState extends State<CareerPaddy> {
  @override
  void initState() {
    LinkService.handleLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => InterestProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => PlansProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
