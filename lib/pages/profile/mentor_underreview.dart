import 'dart:io' show exit;
import 'package:flutter/material.dart';

class MentorReview extends StatelessWidget {
  const MentorReview({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('In-review'),
      content: Text(
        'Your mentor account has been submitted for review. Kindly wait for a response. You can begin to access your account after confirmation.',
      ),
      actions: [
        TextButton(
          onPressed: () => exit(0),
          child: Text('Exit'),
        ),
      ],
    );
  }
}
