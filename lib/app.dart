import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:career_paddy/pages/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

class CareerPaddy extends StatelessWidget {
  const CareerPaddy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
