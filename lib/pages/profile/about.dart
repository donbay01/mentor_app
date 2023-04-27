import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/profile/experiences.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class AboutProfile extends StatefulWidget {
  final UserModel user;

  const AboutProfile({
    super.key,
    required this.user,
  });

  @override
  State<AboutProfile> createState() => _AboutProfileState();
}

class _AboutProfileState extends State<AboutProfile> {
  late bool _c, _m;
  var service = AuthService();

  @override
  void initState() {
    _c = widget.user.isCareerMentor;
    _m = widget.user.isMockInterviewer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: mediumBold(primaryBlack),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.user.bio ?? 'No bio setup',
          style: mediumText(textGrey),
        ),
        SizedBox(
          height: 20,
        ),
        //Job Experiences
        Text(
          'Experience',
          style: mediumBold(darkBlue),
        ),
        Experiences(
          experiences: widget.user.experiences,
        ),
        SizedBox(
          height: 20,
        ),

      ],
    );
  }
}
