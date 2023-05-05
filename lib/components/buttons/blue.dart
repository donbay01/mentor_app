import 'package:flutter/material.dart';
import '../../theme/color.dart';

class BlueButton extends StatelessWidget {
  final Widget widget;
  final Function function;
  final double radius;

  const BlueButton({
    super.key,
    required this.widget,
    required this.function,
    this.radius = 32,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
