import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CardOption extends StatelessWidget {
  final String title, subtitle;
  final bool value;
  final Function function;

  const CardOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        width: double.infinity,
        height: 74,
        decoration: BoxDecoration(
          border: Border.all(color: value ? primaryBlue : Color(0xffeaecf0)),
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: mediumBold(darkBlue),
                ),
                Text(
                  // accessmentorsforcareeradviceTJ (I217:4842;217:4643)
                  subtitle,
                  style: tiny(greyText),
                ),
              ],
            ),
            Checkbox(
              value: value,
              onChanged: (val) => function(),
            ),
          ],
        ),
      ),
    );
  }
}
