import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';
import '../../theme/color.dart';

class MentorSocial extends StatelessWidget {
  const MentorSocial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _resume = TextEditingController();
    TextEditingController _portfolio = TextEditingController();

    var service = AuthService();
    var user = service.getFirebaseUser()!;
    var live = context.watch<UserProvider>().getUser;

    _resume.text = live.resume ?? '';

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
              controller: _resume,
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
