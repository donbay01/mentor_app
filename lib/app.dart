import 'package:flutter/material.dart';
import 'package:career_paddy/pages/splash_screen/splash_screen.dart';

class CareerPaddy extends StatelessWidget {
  const CareerPaddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
