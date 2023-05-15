import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../components/drawer/profile_icon.dart';
import '../../services/picker.dart';
import '../../services/upload.dart';

class ProfileAvatar extends StatefulWidget {
  final User user;

  const ProfileAvatar({
    super.key,
    required this.user,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  UploadTask? task;
  final service = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().getUser;

    return GestureDetector(
      onTap: () async {
        try {
          var photo = await Picker.pickImage();
          task = UploadService.upload('users/${widget.user.uid}', photo!);
          setState(() {});
          await task;

          var url = await UploadService.getUrl(task!);
          await widget.user.updatePhotoURL(url);
          await service.updateField({'photoURL': url});

          setState(() {
            task = null;
          });
        } catch (e) {
          print(e);
        }
      },
      child: Stack(
        children: [
          if (task == null) ...[
            ProfileIcon(
              isExternal: true,
              image: user.photoURL,
            ),
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
          ] else ...[
            StreamBuilder(
              stream: task!.snapshotEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  var progressPercent = data.bytesTransferred / data.totalBytes;

                  return CircularProgressIndicator(value: progressPercent);
                }

                return Text('Please wait...');
              },
            ),
          ],
        ],
      ),
    );
  }
}
