import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/drawer/profile_icon.dart';
import '../../services/picker.dart';
import '../../services/upload.dart';

class ProfileAvatar extends StatelessWidget {
  final User user;

  const ProfileAvatar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var photo = await Picker.pickImage();
        var task = UploadService.upload('users/${user.uid}', photo!);
        await task;

        var url = await UploadService.getUrl(task);
        print(url);
        await user.updatePhotoURL(url);
      },
      child: Stack(
        children: [
          ProfileIcon(),
          Positioned(
            top: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white.withOpacity(0.8),
                child: Icon(FontAwesomeIcons.camera),
              ),
            ),
          )
        ],
      ),
    );
  }
}
