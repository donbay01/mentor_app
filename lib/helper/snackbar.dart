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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}
