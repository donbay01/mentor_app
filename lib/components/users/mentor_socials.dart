import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../../theme/color.dart';

class MentorSocial extends StatefulWidget {
  final UserModel user;
  final GlobalKey<FormState> formKey;

  const MentorSocial({
    Key? key,
    required this.user,
    required this.formKey,
  }) : super(key: key);

  @override
  State<MentorSocial> createState() => _MentorSocialState();
}

class _MentorSocialState extends State<MentorSocial> {
  TextEditingController _resume = TextEditingController();
  TextEditingController _portfolio = TextEditingController();

  @override
  void initState() {
    var a = context.read<UserProvider>();
    _resume.text = a.getResume ?? widget.user.resume ?? '';
    _portfolio.text = a.getLinkedin ?? widget.user.linkedin ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _resume.dispose();
    _portfolio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.read<UserProvider>();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LinkedIn Profile",
              style: mediumText(darkBlue),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _portfolio,
              onChanged: (value) => provider.holdLinkedin(_portfolio.text),
              decoration: InputDecoration(
                hintText: 'Your LinkedIn Profile',
                hintStyle: smallText(greyText),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: greyText,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: primaryBlue),
                ),
              ),
              validator: (value) {
                bool isLink = Uri.tryParse(value!)?.hasAbsolutePath ?? false;

                if (!isLink) {
                  return 'Input a valid link';
                }

                // return 'Valid link';
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Portfolio link",
              style: mediumText(darkBlue),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                bool isLink = Uri.tryParse(value!)?.hasAbsolutePath ?? false;

                if (!isLink) {
                  return 'Input a valid link';
                }

                // return 'Valid link';
              },
              controller: _resume,
              onChanged: (value) => provider.holdResume(_resume.text),
              decoration: InputDecoration(
                hintText: 'URL to access resume',
                hintStyle: smallText(textGrey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
