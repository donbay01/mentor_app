import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPianoWave(
        color: primaryBlue,
        size: 50.0,
      ),
    );
  }
}
