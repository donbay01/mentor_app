import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcase extends StatelessWidget {
  final Widget child;
  final String description;
  final String title;
  final GlobalKey globalKey;

  const CustomShowcase({
    super.key,
    required this.child,
    required this.description,
    required this.title,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      overlayOpacity: 0.85,
      descriptionPadding: EdgeInsets.all(10),
      title: title,
      titlePadding: EdgeInsets.symmetric(horizontal: 10),
      description: description,
      descTextStyle: mediumText(primaryBlue),
      child: child,
      overlayColor: Colors.black87,
      textColor: primaryBlue,
    );
  }
}
