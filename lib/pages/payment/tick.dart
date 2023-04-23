import 'package:flutter/material.dart';

class Tick extends StatelessWidget {
  const Tick({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle,
      color: Colors.green,
      size: 15,
    );
  }
}
