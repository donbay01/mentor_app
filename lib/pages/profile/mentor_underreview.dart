import 'dart:io' show exit;
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class MentorReview extends StatelessWidget {
  const MentorReview({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('In-review',style: largeText(primaryBlack),),
      content: Text(
        'Your mentor account has been submitted for review.\nKindly wait for a response. You can begin to access your account after confirmation.\n\nThank You!',
      style: medium(),
      ),
      actions: [
        TextButton(
          onPressed: () => exit(0),
          child: Text('Exit',style: mediumBold(primaryBlue),),
        ),
      ],
    );
  }
}
