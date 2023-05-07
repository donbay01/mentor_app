import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int? minLines, maxLines, maxLength;
  final TextEditingController controller;
  final String? hint;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hint,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: smallBold(primaryBlack),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: minLines,
          maxLengthEnforcement:
              MaxLengthEnforcement.truncateAfterCompositionEnds,
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: smallText(textGrey),
            suffixIcon: controller.text.isEmpty
                ? Container(
                    width: 0,
                  )
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller.clear();
                    },
                  ),
            filled: true,
            fillColor: primaryWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: darkBlue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: primaryBlue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
