import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/providers/course.dart';
import 'package:career_paddy/providers/date.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/link.service.dart';
import 'package:flutter/material.dart';
import 'package:career_paddy/pages/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'theme/color.dart';
import 'theme/text_style.dart';

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
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.white,
            titleTextStyle: mediumText(primaryBlue),
            toolbarTextStyle: mediumText(primaryBlue),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
