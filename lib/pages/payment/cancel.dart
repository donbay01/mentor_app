import 'package:flutter/material.dart';

class Cancel extends StatelessWidget {
  const Cancel({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.cancel,
      color: Colors.red,
      size: 15,
    );
  }
}
