import 'package:career_paddy/pages/profile/completed_mentor.dart';
import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/fcm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/role.dart';
import '../../helper/snackbar.dart';
import '../../services/progress.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class SaveButton extends StatelessWidget {
  final bool isNot;
  final bool isBuddy;
  final GlobalKey<FormState> formKey;

  const SaveButton({
    super.key,
    required this.formKey,
    this.isNot = false,
    this.isBuddy = false,
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
          Consumer<UserProvider>(
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () async {
                  formKey.currentState!.validate();

                  if (value.bio == null || value.bio!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the bio field',
                      primaryBlue,
                    );
                  }

                  if (value.getGender == null || value.getGender!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the gender field',
                      primaryBlue,
                    );
                  }

                  if (value.getEmployment == null ||
                      value.getEmployment!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the employment field',
                      primaryBlue,
                    );
                  }

                  // if (value.experiences.isEmpty) {
                  //   return SnackBarHelper.displayToastMessage(
                  //     context,
                  //     'Fill in the experiences field',
                  //     primaryBlue,
                  //   );
                  // }

                  if (value.getInterests == null ||
                      value.getInterests!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the interests field',
                      primaryBlue,
                    );
                  }

                  if (value.getLinkedin == null || value.getLinkedin!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the Linkedin field',
                      primaryBlue,
                    );
                  }

                  if (value.getResume == null || value.getResume!.isEmpty) {
                    return SnackBarHelper.displayToastMessage(
                      context,
                      'Fill in the portfolio field',
                      primaryBlue,
                    );
                  }

                  // var isValid = formKey.currentState!.validate();
                  // if (isBuddy && !isValid) {
                  //   SnackBarHelper.displayToastMessage(
                  //     context,
                  //     'Fill in all required fields',
                  //     primaryBlue,
                  //   );
                  //   return;
                  // }
                  // await ProgressService.show(context);

                  try {
                    await ProgressService.show(context);
                    await service.updateProfile(
                      user: provider.getUser,
                      gender: provider.getGender,
                      employment: provider.getEmployment,
                      resume: provider.getResume,
                      interests:
                          provider.getInterests?.map((e) => e.name).toList(),
                      company: provider.getCompany,
                      field: provider.getField,
                      linkedin: provider.getLinkedin,
                      bio: provider.bio,
                      experiences: provider.experiences,
                      isCareerMentor:
                          provider.isCareerMentor ?? user.isCareerMentor,
                      isMockInterviewer:
                          provider.isMockInterviewer ?? user.isMockInterviewer,
                    );
                    service.indexInterests();
                    await ProgressService.hide();
                    if (user.role == MENTOR && user.reviewed) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaddyProfile(),
                        ),
                      );
                    } else if (user.role == MENTOR && !user.reviewed) {
                      await FCMService.showLocal(
                        title: 'Paddy Account',
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
                          builder: (_) => PaddyProfile(),
                        ),
                      );
                    }

                    SnackBarHelper.displayToastMessage(
                      context,
                      'Updated profile',
                      primaryBlue,
                    );
                  } catch (e) {
                    print(e);
                    var err = e as dynamic;
                    SnackBarHelper.displayToastMessage(
                      context,
                      err['message'],
                      primaryBlue,
                    );
                  }
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
              );
            },
          ),
        ],
      ),
    );
  }
}
