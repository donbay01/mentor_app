import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/snackbar.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();
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
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PaddyProfile()),
              );
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
              backgroundColor: secondaryBlue,
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
