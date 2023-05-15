import 'package:career_paddy/pages/profile/buddy_profile.dart';
import 'package:career_paddy/pages/profile/completed_mentor.dart';
import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/fcm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/role.dart';
import '../../helper/snackbar.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class SaveButton extends StatelessWidget {
  final bool isNot;

  const SaveButton({
    super.key,
    this.isNot = false,
  });

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();
    var user = provider.getUser;
    var service = AuthService();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                ' Cancel',
                style: mediumText(primaryBlack),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryWhite,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await service.updateProfile(
                user: provider.getUser,
                gender: provider.getGender,
                employment: provider.getEmployment,
                resume: provider.getResume,
                interests: provider.getInterests?.map((e) => e.name).toList(),
                company: provider.getCompany,
                field: provider.getField,
                linkedin: provider.getLinkedin,
                bio: provider.bio,
                experiences: provider.experiences,
                isCareerMentor: provider.isCareerMentor ?? user.isCareerMentor,
                isMockInterviewer:
                    provider.isMockInterviewer ?? user.isMockInterviewer,
              );
              service.indexInterests();
              if (user.role == MENTOR && user.reviewed) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaddyProfile(),
                  ),
                );
              } else if (user.role == MENTOR && !user.reviewed) {
                await FCMService.showLocal(
                  title: 'Mentor Account',
                  body: 'Your account is being reviewed',
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CompletedProfile(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BuddyProfile(),
                  ),
                );
              }

              SnackBarHelper.displayToastMessage(
                context,
                'Updated profile',
                primaryBlue,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(' Save Changes'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
