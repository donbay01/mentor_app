import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../theme/color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryWhite,
      child: SpinKitSpinningLines(
        duration: Duration(seconds: 3),
        size: 90,
        color: primaryBlue,
      ),
    );
  }
}
