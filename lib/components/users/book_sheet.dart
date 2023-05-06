import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/components/users/tab.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'book_btn.dart';

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
    var prov = context.read<UserProvider>();

    return SizedBox(
      height: size.height * 0.9,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
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
                                    context.read<UserProvider>().cancelShift();
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
                          left: 20,
                          top: 100,
                          child: Align(
                            child: ProfileIcon(
                              isExternal: true,
                              radius: 60,
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
                  UserTab(
                    user: user,
                    meetingType: meetingType,
                    mentee: mentee,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // prov.cancelShift();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width * 0.45,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffeaecf0)),
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: medium(),
                      ),
                    ),
                  ),
                ),
                BookButton(
                  mentee: mentee,
                  user: user,
                  meetingType: meetingType,
                  note: prov.note ?? '',
                  role: prov.jobRole ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
