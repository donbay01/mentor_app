import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcase extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcase({
    super.key,
    required this.child,
    required this.description,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      overlayOpacity: 1,
      description: description,
      child: child,
      overlayColor: Colors.black87,
      textColor: primaryBlue,
    );
  }
}
