import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/about.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/components/users/tab.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class BookSheet extends StatelessWidget {
  final UserModel user, mentee;
  final String meetingType;

  const BookSheet({
    super.key,
    required this.user,
    required this.mentee,
    this.meetingType = CAREER_SESSION,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
              width: double.infinity,
              height: 182,
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.17,
                    decoration: BoxDecoration(
                      color: secondaryBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                              size: 30,
                              color: primaryWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    // avatarxgJ (80:763)
                    left: 20,
                    top: 100,
                    child: Align(
                      child: ProfileIcon(
                        isExternal: true,
                        radius: 70,
                        image: user.photoURL,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                    child: Text(
                      '${user.first_name} ${user.last_name}',
                      style: mediumBold(primaryBlack),
                    ),
                  ),
                  UsersInterests(user: user),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            UserTab(),
            About(
              user: user,
              mentee: mentee,
              meetingType: meetingType,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
