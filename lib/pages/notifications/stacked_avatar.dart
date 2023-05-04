import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';

class StackedAvatars extends StatelessWidget {
  final String? mentorImage, menteeImage;
  final double? height, width;

  const StackedAvatars({
    super.key,
    required this.mentorImage,
    required this.menteeImage,
    this.height = 50,
    this.width = 100,
  });

  ImageProvider<Object> imageUi(String? url) {
    if (url == null) {
      return AssetImage('assets/avatar.png');
    }

    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarStack(
          width: width,
          height: height,
          avatars: [
            imageUi(mentorImage),
            imageUi(menteeImage),
          ],
        )
      ],
    );
  }
}
