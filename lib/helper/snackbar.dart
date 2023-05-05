import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static displayToastMessage(
    BuildContext context,
    String message,
    Color color,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: medium()
        ),
        backgroundColor: color,
      ),
    );
  }
}
